#
# Stage and Stage Settings
#

resource "aws_api_gateway_stage" "atmster" {
  deployment_id = aws_api_gateway_deployment.atmster.id
  rest_api_id   = aws_api_gateway_rest_api.atmster.id
  stage_name    = "atmster"
}

resource "aws_api_gateway_method_settings" "atmster" {
  rest_api_id = aws_api_gateway_rest_api.atmster.id
  stage_name  = aws_api_gateway_stage.atmster.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
  }
}
