resource "local_file" "lambda_source" {
  filename = "${path.root}/scripts/lambda_s3_event.py"
  content = templatefile("${path.module}/lambda_s3_event.tpl",
  {
    destination_bucket_name = var.artifacts_bucket_name
  })
}

data "archive_file" "lambda_zip" {
  type          = "zip"
  source_file   = "${path.root}/scripts/lambda_s3_event.py"
  output_path   = "${path.root}/packages/lambda_s3_event.zip"

  depends_on = [
    local_file.lambda_source
  ]
}

resource "aws_lambda_function" "test_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "s3-event-buckets-sync"
  role             = aws_iam_role.iam_for_lambda_tf.arn
  handler          = "lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"

  tags = var.tags
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}