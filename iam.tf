resource "aws_iam_role" "instance_role" {
    name = "instance_role"
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

resource "aws_iam_role" "service_role" {
    name = "service_role"
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

resource "aws_iam_role_policy" "ecs_instance_policy" {
    name = "ecs_instance_policy"
    role = "${aws_iam_role.instance_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
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
  }]
}
EOF
}
resource "aws_iam_role_policy" "ecs_service_policy" {
    name = "ecs_service_policy"
    role = "${aws_iam_role.service_role.id}"
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

resource "aws_iam_instance_profile" "default" {
    name = "empire profile"
    roles = ["${aws_iam_role.instance_role.name}"]
}

