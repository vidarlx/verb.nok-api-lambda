resource "aws_api_gateway_stage" "test" {
  stage_name    = "prod"
  rest_api_id   = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  deployment_id = "${aws_api_gateway_deployment.verbs_nok_api_test_deployment.id}"
}

resource "aws_api_gateway_deployment" "verbs_nok_api_test_deployment" {
  depends_on = ["aws_api_gateway_integration.get_verbs"]

  rest_api_id = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  stage_name  = "test"

  variables = {
    "env" = "test"
  }
}
