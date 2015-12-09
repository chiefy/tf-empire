/* AutoScalingGroup */
resource "aws_autoscaling_group" "ecs" {
  name = "${var.prefix}-ecs"
  availability_zones = ["${aws_subnet.public.*.availability_zone}"]
  vpc_zone_identifier = ["${aws_subnet.public.*.id}"]
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  min_size = 1
  max_size = 10
  desired_capacity = 3
}
