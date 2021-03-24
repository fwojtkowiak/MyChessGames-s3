resource "aws_lambda_layer_version" "lambda_layer_requests" {
  filename   = "../lambda/python.zip"
  layer_name = "lambda_layer_requests"

  compatible_runtimes = ["python3.8", "python3.7"]
}