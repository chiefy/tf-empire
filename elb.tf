
/* LoadBalancer */
resource "aws_elb" "empire" {
  name = "${var.prefix}-empire"
  security_groups = ["${aws_security_group.ecs.id}"]
  subnets = ["${aws_subnet.public.*.id}"]

  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = 8080
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 10
    target = "HTTP:8080/health"
    interval = 30
    timeout = 5
  }
}
