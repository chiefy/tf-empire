resource "aws_ecs_cluster" "empire_cluster" {
  name = "empire"
}

resource "template_file" "empire_task" {
    filename = "tasks/empire.tmpl.json"
    vars {
      vpc_id = "${aws_vpc.empire_vpc.id}"
      aws_region = "${var.aws_region}"
      cluster_name = "${aws_ecs_cluster.empire_cluster.name}"
      sg_private = "${aws_security_group.internal_elb.id}"
      sg_public = "${aws_security_group.external_elb.id}"
      dns_zone_id = "${aws_route53_zone.primary.id}"
      subnets_private = "${aws_subnet.us-east-1b-private.id},${aws_subnet.us-east-1d-private.id}"
      subnets_public = "${aws_subnet.us-east-1b-public.id},${aws_subnet.us-east-1d-public.id}"
      service_role = "${aws_iam_role.service_role.id}"
    }
}

resource "aws_ecs_task_definition" "empire_task" {
  family = "empire"
  container_definitions = "${template_file.empire_task.rendered}"

  volume {
    name = "dockerSocket"
    host_path = "/var/run/docker.sock"
  }

  volume {
    name = "dockerCfg"
    host_path = "/home/ec2-user/.docker/config.json"
  }
}

resource "aws_ecs_service" "empire_service" {
  name = "empire"
  cluster = "${aws_ecs_cluster.empire_cluster.id}"
  task_definition = "${aws_ecs_task_definition.empire_task.arn}"
  desired_count = 1
  iam_role = "${aws_iam_role.service_role.arn}"
  depends_on = ["aws_iam_role_policy.ecs_service_policy"]

  load_balancer {
    elb_name = "${aws_elb.empire.id}"
    container_name = "empire"
    container_port = 8080
  }
}
