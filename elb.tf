resource "aws_elb" "empire" {
  name = "empire-external-elb"
  subnets = [
    "${aws_subnet.us-east-1b-public.id}",
    "${aws_subnet.us-east-1d-public.id}"
  ]
  security_groups = ["${aws_security_group.external_elb.id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 5
    unhealthy_threshold = 5
    timeout = 5
    target = "HTTP:8080/health"
    interval = 30
  }
}
