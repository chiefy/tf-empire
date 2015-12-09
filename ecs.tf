/* Cluster */
resource "aws_ecs_cluster" "empire" {
  name = "${var.prefix}-empire"
}

/* TaskDefinition */
resource "template_file" "empire_container_definitions" {
  filename = "tasks/empire.tmpl.json"
  vars {
    rds_addr = "${aws_db_instance.default.address}:${aws_db_instance.default.port}"
    region = "${var.region}"
    cluster = "${aws_ecs_cluster.empire.id}"
    vpc_id = "${aws_vpc.default.id}"
    sg_private = "${aws_security_group.ilb.id}"
    sg_public = "${aws_security_group.elb.id}"
    zone = "${aws_route53_zone.private.id}"
    subnets_private = "${join(",", aws_subnet.public.*.id)}"
    subnets_public = "${join(",", aws_subnet.public.*.id)}"
    service_role = "${aws_iam_role.empire.arn}"
  }
}

/* TaskDefinition */
resource "aws_ecs_task_definition" "empire" {
  family = "${var.prefix}-empire"
  container_definitions = "${template_file.empire_container_definitions.rendered}"

  volume {
    name = "dockerCfg"
    host_path = "/home/ec2-user/.dockercfg"
  }
  volume {
    name = "dockerSocket"
    host_path = "/var/run/docker.sock"
  }
}

/* Service */
resource "aws_ecs_service" "empire" {
  name = "empire"
  cluster = "${aws_ecs_cluster.empire.id}"
  task_definition = "${aws_ecs_task_definition.empire.arn}"
  desired_count = 1
  iam_role = "${aws_iam_role.empire.id}"

  load_balancer {
    elb_name = "${aws_elb.empire.id}"
    container_name = "empire"
    container_port = 8080
  }
}
