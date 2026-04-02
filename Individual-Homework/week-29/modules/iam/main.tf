############################################
# IAM Role for EC2 (Jenkins)
############################################

resource "aws_iam_role" "jenkins_ec2_role" {
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

############################################
# IAM Policy for EC2 (SSM + Logs + Secrets)
############################################

resource "aws_iam_policy" "jenkins_ec2_policy" {
  name        = "${var.project_name}-ec2-policy"
  description = "Policy for Jenkins EC2 instance"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [

      # -------------------------------------------------------
      # SSM Agent + Command Access (partial, not enough alone)
      # -------------------------------------------------------
      {
        Effect = "Allow"
        Action = [
          "ssm:DescribeInstanceInformation",
          "ssm:GetCommandInvocation",
          "ssm:ListCommands",
          "ssm:ListCommandInvocations",
          "ssm:SendCommand",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ]
        Resource = "*"
      },

      # -------------------------------------------------------
      # CloudWatch Logs
      # -------------------------------------------------------
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },

      # -------------------------------------------------------
      # Secrets Manager
      # -------------------------------------------------------
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = [
          var.jenkins_admin_secret_arn,
          var.github_pat_secret_arn
        ]
      },

      # -------------------------------------------------------
      # SSM Parameter Store
      # -------------------------------------------------------
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = [
          var.jenkins_admin_secret_arn,
          var.github_pat_secret_arn
        ]
      }
    ]
  })
}

############################################
# Attach Custom Policy to Role
############################################

resource "aws_iam_role_policy_attachment" "jenkins_ec2_attach" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = aws_iam_policy.jenkins_ec2_policy.arn
}

############################################
# REQUIRED: Attach AWS SSM Core Policy
############################################

resource "aws_iam_role_policy_attachment" "jenkins_ssm_core" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

############################################
# Instance Profile
############################################

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.jenkins_ec2_role.name
}
