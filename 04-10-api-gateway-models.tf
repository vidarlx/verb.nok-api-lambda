resource "aws_api_gateway_model" "get_verbs" {
  rest_api_id  = "${aws_api_gateway_rest_api.verbs_nok_api.id}"
  name         = "GetVerbsSchema"
  description  = "a JSON schema"
  content_type = "application/json"

  schema = <<EOF
{
    "type": "array",
    "items": {
        "type": "object",
        "properties": {
            "norsk_verb": {
                "type": "string"
            },
            "polsk_verb": {
                "type": "string"
            }
        }
    }
}
EOF
}
