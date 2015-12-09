resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.prefix}-default"
  }
}

/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "${aws_vpc.default.tags.Name}"
  }
}
