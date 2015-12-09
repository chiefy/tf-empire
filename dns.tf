
resource "aws_route53_record" "empire" {
  zone_id = "${aws_route53_zone.private.id}"
  name = "${aws_ecs_cluster.empire.name}-${var.region}"
  type = "A"

  alias {
    name = "${aws_elb.empire.dns_name}"
    zone_id = "${aws_elb.empire.zone_id}"
    evaluate_target_health = true
  }

}

/* InternalDomain */
resource "aws_route53_zone" "private" {
  name = "${var.domain}"
  comment = "${var.prefix}-${var.region} (Managed by Terraform and Empire)"
  vpc_id = "${aws_vpc.default.id}"
}
