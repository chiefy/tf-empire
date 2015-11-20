# NAT instance

resource "aws_security_group" "nat" {
  name = "nat"
  description = "Allow services from the private subnet through NAT"

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["${aws_subnet.us-east-1b-private.cidr_block}"]
  }
  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["${aws_subnet.us-east-1d-private.cidr_block}"]
  }

  vpc_id = "${aws_vpc.empire_vpc.id}"
}

resource "aws_instance" "nat" {
  ami = "${var.aws_nat_ami}"
  availability_zone = "us-east-1b"
  instance_type = "m1.small"
  key_name = "${var.aws_key_name}"
  security_groups = ["${aws_security_group.nat.id}"]
  subnet_id = "${aws_subnet.us-east-1b-public.id}"
  associate_public_ip_address = true
  source_dest_check = false
}

resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc = true
}
