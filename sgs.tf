
/* Default security group */
resource "aws_security_group" "default" {
  name = "${var.prefix}-default"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  tags {
    Name = "${var.prefix}-default"
  }
}

/* NAT security group */
resource "aws_security_group" "nat" {
  name = "${var.prefix}-nat"
  description = "Security group for NAT instances that allows SSH and VPN traffic from the internet. Also allows outbound HTTP[S]"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.prefix}-nat"
  }
}

/* ExternalLoadBalancerSecurityGroup */
resource "aws_security_group" "elb" {
  name = "${var.prefix}-elb"
  description = "External Load Balancer Allowed Ports"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.prefix}-ilb"
  }
}
/* InternalLoadBalancerSecurityGroup */
resource "aws_security_group" "ilb" {
  name = "${var.prefix}-ilb"
  description = "Internal Load Balancer Allowed Ports"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.prefix}-ilb"
  }
}
/* InstanceSecurityGroup */
resource "aws_security_group" "ecs" {
  name = "${var.prefix}-ecs"
  description = "Container Instance Allowed Ports"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 1
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.prefix}-ecs"
  }
}

/* RDSSecurityGroup */
resource "aws_security_group" "rds" {
  name = "${var.prefix}-rds"
  description = "RDS security group"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = ["10.64.0.0/18"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["10.64.0.0/18"]
  }

  tags {
    Name = "${var.prefix}-rds"
  }
}

