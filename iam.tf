resource "aws_iam_role" "machine" {
  name               = "${local.system_name}-machine-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "${local.system_name}-machine-role-policy"
  path        = "/"
  description = "dynamodb access iam policy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:*",
        "cloudwatch:*",
        "events:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.machine.name
  policy_arn = aws_iam_policy.policy.arn
}
resource "aws_iam_instance_profile" "machine" {
  name_prefix = "${local.system_name}-instance"
  role        = aws_iam_role.machine.name
}
