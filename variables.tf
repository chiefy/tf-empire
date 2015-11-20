variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}
variable "aws_region" {
  default = "us-east-1"
}
variable "aws_nat_ami" {
  default = "ami-2e1bc047"
}
variable "aws_ubuntu_ami" {
  default = "ami-b227efda"
}
variable "aws_ecs_ami" {
  default = "ami-5943023c"
}
variable "empire_version" {
  default = "master"
}
variable "aws_instance_type" {
  default = "t2.small"
}
variable "docker_registry" {
  default = "https://index.docker.io/v1/"
}

