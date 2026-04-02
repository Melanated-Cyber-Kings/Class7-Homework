data "aws_caller_identity" "current" {}

output "jenkins_admin_secret_arn" {
  value = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
    ) ? try(
    aws_secretsmanager_secret.jenkins_admin_protected[0].arn,
    aws_secretsmanager_secret.jenkins_admin_destroyable[0].arn
  ) : "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/jenkins-admin-password"
}

output "github_pat_secret_arn" {
  value = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
    ) ? try(
    aws_secretsmanager_secret.github_pat_protected[0].arn,
    aws_secretsmanager_secret.github_pat_destroyable[0].arn
  ) : "arn:aws:ssm:${var.region}:${data.aws_caller_identity.current.account_id}:parameter/${var.project_name}/github-pat"
}
