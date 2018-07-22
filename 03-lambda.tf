data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "lambda"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "get_verbs_keys" {
  filename         = "lambda.zip"
  function_name    = "GetVerbsKeys"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "GetVerbsKeys.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "nodejs6.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

resource "aws_lambda_function" "get_verb" {
  filename         = "lambda.zip"
  function_name    = "GetVerb"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "GetVerb.handler"
  source_code_hash = "${data.archive_file.lambda_zip.output_base64sha256}"
  runtime          = "nodejs6.10"
}
