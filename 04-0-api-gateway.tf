resource "aws_api_gateway_rest_api" "verbs_nok_api" {
  name = "VerbsNokApi"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "verbs_nok_api_verbs_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.verbs_nok_api.root_resource_id}"
  path_part   = "get-verbs"
}

resource "aws_api_gateway_method" "verbs_nok_api_get_verbs_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  resource_id   = "${aws_api_gateway_resource.verbs_nok_api_verbs_resource.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "verbs_nok_api_get_verbs_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  resource_id             = "${aws_api_gateway_resource.verbs_nok_api_verbs_resource.id}"
  http_method             = "${aws_api_gateway_method.verbs_nok_api_get_verbs_method.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/${aws_lambda_function.get_verbs_keys.arn}/invocations"
}

resource "aws_lambda_permission" "get_verbs_lambda_permission" {
  statement_id  = "AllowGetVerbsKeysInvokeFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.get_verbs_keys.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.verbs_nok_api.execution_arn}/*/*/get-verbs"
}
