output "api_url" {
  value = aws_api_gateway_rest_api.api.execution_arn
}

output "python_endpoint" {
  value = "${aws_api_gateway_stage.prod.invoke_url}/python"
}

output "node_endpoint" {
  value = "${aws_api_gateway_stage.prod.invoke_url}/node"
}
