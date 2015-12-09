variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "region" {
  default = "us-east-1"
}

variable "empire_version" {
  default = "master"
}

variable "ecs_instance_type" {
  description = "ECS instance type"
  default = "t2.small"
}

variable "prefix" {
  description = "Environment prefix"
  default = "odd"
}

variable "dns_ttl" {
  description = "DNS TTL to use for records"
  default     = "300"
}

variable "availability_zone_count" {
  description = "Number of Availability Zones"
  default = "2"
}

variable "availability_zones" {
  description = "Availability Zones"
  default = {
    "0" = "b"
    "1" = "d"
  }
}

variable "domain" {
  description = "Top-level domain name"
  default     = "empire"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.64.0.0/18"
}

variable "public_subnet_cidrs" {
  description = "Public CIDR"
  default     = {
    "0" = "10.64.0.0/22"
    "1" = "10.64.16.0/22"
    "2" = "10.64.32.0/22"
  }
}

variable "private_subnet_cidrs" {
  description = "Private CIDR"
  default     = {
    "0" = "10.64.4.0/22"
    "1" = "10.64.8.0/22"
    "2" = "10.64.12.0/22"
  }
}

/* Ubuntu 14.04 AMIs by region */
variable "amis" {
  description = "Base AMIs"
  default = {
    "eu-central-1" = "ami-b4d3e1a9"
    "eu-west-1" = "ami-cba130bc"
    "us-east-1" = "ami-a6b8e7ce"
    "us-west-1" = "ami-049d8641"
  }
}

/* ECS AMIs by region */
variable "ecs_amis" {
  description = "ECS AMIs"
  default = {
    "eu-west-1" = "ami-3fa4de48"
    "us-east-1" = "ami-5449393e"
    "us-west-2" = "ami-27212417"
  }
}

variable "docker_registry" {
  description = "Docker private registry URL"
  default = "https://index.docker.io/v1/"
}

variable "docker_email" {
  default = ""
}

variable "docker_auth" {
  default = ""
}
