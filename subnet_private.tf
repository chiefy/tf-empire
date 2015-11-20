# Private subsets

resource "aws_subnet" "us-east-1b-private" {
  vpc_id = "${aws_vpc.empire_vpc.id}"

  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_subnet" "us-east-1d-private" {
  vpc_id = "${aws_vpc.empire_vpc.id}"

  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1d"
}

# Routing table for private subnets

resource "aws_route_table" "us-east-1-private" {
  vpc_id = "${aws_vpc.empire_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "us-east-1b-private" {
  subnet_id = "${aws_subnet.us-east-1b-private.id}"
  route_table_id = "${aws_route_table.us-east-1-private.id}"
}

resource "aws_route_table_association" "us-east-1d-private" {
  subnet_id = "${aws_subnet.us-east-1d-private.id}"
  route_table_id = "${aws_route_table.us-east-1-private.id}"
}
