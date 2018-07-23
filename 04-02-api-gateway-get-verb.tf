resource "aws_api_gateway_resource" "get_verb" {
  rest_api_id = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.verbs_nok_api.root_resource_id}"
  path_part   = "get-verb"
}

resource "aws_api_gateway_model" "get_verb" {
  rest_api_id  = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  name         = "GetVerbRequestSchema"
  description  = "Verb request schema"
  content_type = "application/json"

  schema = <<EOF
{
  "type": "string"
}
EOF
}

resource "aws_api_gateway_method" "get_verb" {
  rest_api_id   = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  resource_id   = "${aws_api_gateway_resource.get_verb.id}"
  http_method   = "POST"
  authorization = "NONE"

  request_models {
    "application/json" = "${aws_api_gateway_model.get_verb.name}"
  }
}

resource "aws_api_gateway_integration" "get_verb" {
  rest_api_id             = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  resource_id             = "${aws_api_gateway_resource.get_verb.id}"
  http_method             = "${aws_api_gateway_method.get_verb.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/${aws_lambda_function.get_verb.arn}/invocations"
}

resource "aws_lambda_permission" "get_verb_lambda_ag" {
  statement_id  = "AllowGetVerbsKeysInvokeFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.get_verb.function_name}"
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.verbs_nok_api.execution_arn}/*/*/get-verb"
}
