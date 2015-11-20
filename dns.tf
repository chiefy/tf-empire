resource "aws_route53_zone" "primary" {
   name = "empire."
   vpc_id = "${aws_vpc.empire_vpc.id}"
}
