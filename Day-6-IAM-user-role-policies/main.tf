# IAM group
resource "aws_iam_group" "developers" {
  name = "${var.project_name}-developers"
}

# IAM user
resource "aws_iam_user" "developer" {
  name = "${var.project_name}-developer"
  path = "/lab/"
}

# Add user to group
resource "aws_iam_user_group_membership" "developer" {
  user = aws_iam_user.developer.name

  groups = [
    aws_iam_group.developers.name
  ]
}

# Least-privilege policy: list one specified bucket
resource "aws_iam_policy" "s3_list" {
  name        = "${var.project_name}-s3-list"
  description = "Allow listing one designated S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "arn:aws:s3:::replace-with-your-existing-bucket"
      }
    ]
  })
}

# Attach policy to group
resource "aws_iam_group_policy_attachment" "s3_list" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.s3_list.arn
}

# Role trust policy for EC2
resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Instance profile lets EC2 use the role
resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}