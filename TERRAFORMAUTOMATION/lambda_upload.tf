# Zip the contents of the lambda/ folder
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda_function_payload.zip"
}

# Deploy Lambda using the ZIP file
resource "aws_lambda_function" "upload_handler" {
  function_name    = "s3UploadLambda"
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  timeout          = 15
  role             = aws_iam_role.lambda_exec.arn
}
