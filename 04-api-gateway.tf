resource "aws_api_gateway_rest_api" "verbs_nok_api" {
  name = "VerbsNokApi"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "VerbsNokAPIGetMethod" {
  rest_api_id = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.verbs_nok_api.root_resource_id}"
  path_part   = "get-verbs"
}

resource "aws_api_gateway_method" "VerbsNokAPIGetVerbsEndpoint" {
  rest_api_id   = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  resource_id   = "${aws_api_gateway_resource.verbs_nok_api.id}"
  http_method   = "GET"
  authorization = "NONE"
}
