resource "aws_autoscaling_group" "empire_asg" {
  availability_zones = ["us-east-1b"]
  name = "empire_asg"
  max_size = 5
  min_size = 3
  desired_capacity = 3
  vpc_zone_identifier = ["${aws_subnet.us-east-1b-public.id}","${aws_subnet.us-east-1d-public.id}"]
  health_check_grace_period = 300
  health_check_type = "ELB"
  force_delete = true
  launch_configuration = "${aws_launch_configuration.empire_lc.name}"

}
