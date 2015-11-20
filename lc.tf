resource "aws_launch_configuration" "empire_lc" {
    name = "empire_lc"
    image_id = "${var.aws_ecs_ami}"
    instance_type = "${var.aws_instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.default.id}"
    security_groups = ["${aws_security_group.instance.id}"]
    associate_public_ip_address = true
    user_data = "${file("empire_lc_user_data.sh")}"
}
