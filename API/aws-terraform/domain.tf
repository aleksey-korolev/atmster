#
# Domain Setup
#

resource "aws_api_gateway_domain_name" "atmster" {
  domain_name              = aws_acm_certificate.atmster.domain_name
  regional_certificate_arn = aws_acm_certificate.atmster.arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "atmster" {
  api_id      = aws_api_gateway_rest_api.atmster.id
  domain_name = aws_api_gateway_domain_name.atmster.domain_name
  stage_name  = aws_api_gateway_stage.atmster.stage_name
}
