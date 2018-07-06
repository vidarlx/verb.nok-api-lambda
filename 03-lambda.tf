resource "aws_lambda_function" "GetVerbsKeys" {
  filename         = "GetVerbsKeys.zip"
  function_name    = "GetVerbsKeys"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "GetVerbsKeys.handler"
  source_code_hash = "${base64sha256(file("GetVerbsKeys.zip"))}"
  runtime          = "nodejs6.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
