resource "aws_vpc_dhcp_options" "default" {
    domain_name = "empire"
    domain_name_servers = ["AmazonProvidedDNS"]
}
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
    vpc_id = "${aws_vpc.empire_vpc.id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.default.id}"
}
