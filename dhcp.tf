
resource "aws_vpc_dhcp_options" "default" {
  domain_name = "${aws_route53_zone.private.name}"
  domain_name_servers = ["AmazonProvidedDNS"]
  tags {
    Name = "${aws_vpc.default.tags.Name}"
  }
}

resource "aws_vpc_dhcp_options_association" "default" {
  vpc_id = "${aws_vpc.default.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.default.id}"
}
