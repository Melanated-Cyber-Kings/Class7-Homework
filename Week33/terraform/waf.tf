resource "aws_wafv2_web_acl" "chewbacca_waf" {
  name        = "chewbacca-waf"
  description = "WAF with 3 rules: Managed, Geo-Block, and Rate-Limit"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # RULE 1: AWS Managed Rules (Original requirement)
  rule {
    name     = "AWSManagedCommonRuleSet"
    priority = 1
    override_action {
      none {}
    }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "CommonRuleSetMetric"
      sampled_requests_enabled   = true
    }
  }

  # RULE 2: Geo-Blocking (CN and RU)
  rule {
    name     = "GeoBlock"
    priority = 2
    action {
      block {}
    }
    statement {
      geo_match_statement {
        country_codes = ["CN", "RU"]
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "GeoBlockMetric"
      sampled_requests_enabled   = true
    }
  }

  # RULE 3: Rate Limiting (100 requests per 5 mins)
  rule {
    name     = "RateLimit"
    priority = 3
    action {
      block {}
    }
    statement {
      rate_based_statement {
        limit              = 100
        aggregate_key_type = "IP"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitMetric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "chewbaccaWafMetric"
    sampled_requests_enabled   = true
  }
}

# The Association (Links the WAF to your API Gateway Stage)
resource "aws_wafv2_web_acl_association" "api_waf_association" {
  resource_arn = "arn:aws:apigateway:us-east-2::/restapis/${aws_api_gateway_rest_api.api.id}/stages/${aws_api_gateway_stage.prod.stage_name}"
  web_acl_arn  = aws_wafv2_web_acl.chewbacca_waf.arn
}