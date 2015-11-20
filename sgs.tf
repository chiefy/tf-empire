resource "aws_security_group" "instance" {
  name = "instance_sg"
  description = "Container Instance Allowed Ports"
  vpc_id = "${aws_vpc.empire_vpc.id}"

  ingress {
      from_port = 0
      to_port = 0
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "internal_elb" {
  name = "internal_elb_sg"
  description = "Internal Load Balancer Allowed Ports"
  vpc_id = "${aws_vpc.empire_vpc.id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["10.0.0.0/16"]
  }

}


resource "aws_security_group" "external_elb" {
  name = "external_elb_sg"
  description = "External Load Balancer Allowed Ports"
  vpc_id = "${aws_vpc.empire_vpc.id}"

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
  }
}
