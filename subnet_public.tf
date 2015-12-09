/* Public subnet */
resource "aws_subnet" "public" {
  count = "${var.availability_zone_count}"
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${lookup(var.public_subnet_cidrs, count.index)}"
  availability_zone = "${var.region}${lookup(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.default"]
  tags {
    Name = "${var.prefix}-pub-${var.region}${lookup(var.availability_zones, count.index)}"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
  tags {
    Name = "${var.prefix}-public"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public" {
  count = "${var.availability_zone_count}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
