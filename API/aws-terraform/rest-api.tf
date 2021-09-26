resource "aws_api_gateway_rest_api" "atmster" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.rest_api_name
      version = "1.0"
    }
    paths = {
      (var.rest_api_path) = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://atmster.com/comission"
          }
        }
      }
    }
  })

  name = var.rest_api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "atmster" {
  rest_api_id = aws_api_gateway_rest_api.atmster.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.atmster.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}
