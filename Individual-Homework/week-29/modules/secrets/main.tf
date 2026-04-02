############################################
# SSM Parameter Store (default backend)
############################################

resource "aws_ssm_parameter" "jenkins_admin" {
  count     = var.secret_backend == "ssm" || var.secret_backend == "both" ? 1 : 0
  name      = "/${var.project_name}/jenkins-admin-password"
  type      = "SecureString"
  value     = var.jenkins_admin_password
  overwrite = true
}

resource "aws_ssm_parameter" "github_pat" {
  count     = var.secret_backend == "ssm" || var.secret_backend == "both" ? 1 : 0
  name      = "/${var.project_name}/github-pat"
  type      = "SecureString"
  value     = var.github_pat
  overwrite = true
}

############################################
# Secrets Manager (optional backend)
############################################

resource "aws_secretsmanager_secret" "jenkins_admin_protected" {
  count = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
  ) ? (var.destroy_secrets ? 0 : 1) : 0

  name = "${var.project_name}-jenkins-admin-password"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret" "jenkins_admin_destroyable" {
  count = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
  ) ? (var.destroy_secrets ? 1 : 0) : 0

  name = "${var.project_name}-jenkins-admin-password"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_secretsmanager_secret_version" "jenkins_admin_value" {
  count = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
  ) ? 1 : 0

  secret_id = try(
    aws_secretsmanager_secret.jenkins_admin_protected[0].id,
    aws_secretsmanager_secret.jenkins_admin_destroyable[0].id
  )

  secret_string = var.jenkins_admin_password
}

resource "aws_secretsmanager_secret" "github_pat_protected" {
  count = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
  ) ? (var.destroy_secrets ? 0 : 1) : 0

  name = "${var.project_name}-github-pat"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret" "github_pat_destroyable" {
  count = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
  ) ? (var.destroy_secrets ? 1 : 0) : 0

  name = "${var.project_name}-github-pat"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_secretsmanager_secret_version" "github_pat_value" {
  count = (
    var.secret_backend == "secretsmanager" || var.secret_backend == "both"
  ) ? 1 : 0

  secret_id = try(
    aws_secretsmanager_secret.github_pat_protected[0].id,
    aws_secretsmanager_secret.github_pat_destroyable[0].id
  )

  secret_string = var.github_pat
}
