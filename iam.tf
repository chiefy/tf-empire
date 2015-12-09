/* User */
resource "aws_iam_user" "empire" {
  name = "${var.prefix}-empire"
}

/* AccessKey */
resource "aws_iam_access_key" "empire" {
  user = "${aws_iam_user.empire.name}"
}

/* InstanceProfile */
resource "aws_iam_instance_profile" "ecs" {
  name = "${var.prefix}-ecs"
  path = "/"
  roles = ["${aws_iam_role.ecs.name}"]
}

/* InstanceRole */
resource "aws_iam_role" "ecs" {
  name = "${var.prefix}-ecs"
  path = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [ "ec2.amazonaws.com" ]
      },
      "Action": [ "sts:AssumeRole" ]
    }
  ]
}
EOF
}

/* InstancePolicies */
resource "aws_iam_role_policy" "ecs" {
  name = "${var.prefix}-ecs"
  role = "${aws_iam_role.ecs.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "elasticloadbalancing:*",
        "ecs:*",
        "iam:ListInstanceProfiles",
        "iam:ListRoles",
        "iam:PassRole",
        "iam:UploadServerCertificate",
        "iam:DeleteServerCertificate",
        "route53:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_user_policy" "ecs" {
  name = "${var.prefix}-ecs"
  user = "${aws_iam_user.empire.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "elasticloadbalancing:*",
        "ecs:*",
        "iam:ListInstanceProfiles",
        "iam:ListRoles",
        "iam:PassRole",
        "iam:UploadServerCertificate",
        "iam:DeleteServerCertificate",
        "route53:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

/* ServiceRole */
resource "aws_iam_role" "empire" {
  name = "${var.prefix}-empire"
  path = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [ "ecs.amazonaws.com" ]
      },
      "Action": [ "sts:AssumeRole" ]
    }
  ]
}
EOF
}

/* ServiceRolePolicies */
resource "aws_iam_role_policy" "empire" {
  name = "${var.prefix}-empire"
  role = "${aws_iam_role.empire.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:Describe*",
        "elasticloadbalancing:*",
        "ecs:*",
        "iam:ListInstanceProfiles",
        "iam:ListRoles",
        "iam:PassRole",
        "route53:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}
