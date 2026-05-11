# The Parent REST API
resource "aws_api_gateway_rest_api" "api" {
  name = "chewbacca-rest-api"
}

# Python Resource and Method
resource "aws_api_gateway_resource" "python" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "python"
}

resource "aws_api_gateway_method" "python_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.python.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "python_int" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.python.id
  http_method             = aws_api_gateway_method.python_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.python.invoke_arn
}

# Node Resource and Method
resource "aws_api_gateway_resource" "node" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "node"
}

resource "aws_api_gateway_method" "node_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.node.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "node_int" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.node.id
  http_method             = aws_api_gateway_method.node_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.node.invoke_arn
}

# Deployment and Stage
resource "aws_api_gateway_deployment" "deploy" {
  depends_on  = [aws_api_gateway_integration.python_int, aws_api_gateway_integration.node_int]
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "prod"
}