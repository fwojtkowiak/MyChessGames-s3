module "lambda-cloudwatch-trigger" {
  source  = "infrablocks/lambda-cloudwatch-events-trigger/aws"
  region                = var.region
  component             = "lambda_mychessgames"
  deployment_identifier = "${terraform.workspace}"

  lambda_arn =  aws_lambda_function.lambda_mychessgames.arn
  lambda_function_name = "lambda_mychessgames"
  lambda_schedule_expression = "cron(0 8 1 * ? *)"
}





resource "aws_lambda_function" "lambda_mychessgames" {
  filename      = "../lambda/lambda.zip"
  function_name = "lambda_mychessgames"
  role          = aws_iam_role.lambda_role.arn
  layers        = [aws_lambda_layer_version.lambda_layer_requests.arn]
  handler       = "lambda.lambda_handler"
  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("../lambda/lambda.zip")

  runtime = "python3.8"

  environment {
    variables = {
      bucket = var.bucket
    }
  }
}