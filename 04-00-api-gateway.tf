resource "aws_api_gateway_rest_api" "verbs_nok_api" {
  name = "VerbsNokApi"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
