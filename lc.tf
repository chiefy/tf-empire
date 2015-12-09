/* LaunchConfiguration */
resource "template_file" "ecs" {
  filename = "user-data/empire_lc_user_data.sh"
  vars {
    cluster = "${aws_ecs_cluster.empire.name}"
    auth = "${var.docker_auth}"
    email = "${var.docker_email}"
    registry = "${var.docker_registry}"
  }
}

resource "aws_launch_configuration" "ecs" {
  name = "${var.prefix}-ecs"
  key_name = "${var.aws_key_name}"
  image_id = "${lookup(var.ecs_amis, var.region)}"
  instance_type = "${var.ecs_instance_type}"
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.ecs.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.name}"
  associate_public_ip_address = true
  user_data = "${template_file.ecs.rendered}"
}
