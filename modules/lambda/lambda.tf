resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "s3-event-buckets-sync"
  role             = aws_iam_role.exec_role.arn
  handler          = "lambda_s3_event.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.8"

  tags = var.tags
}

data "aws_s3_bucket" "source_bucket" {
  bucket = var.s3_lambda_event_source_bucket
}

resource "aws_lambda_permission" "allow_source_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.source_bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.s3_lambda_event_source_bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_source_bucket]
}

resource "aws_iam_role" "exec_role" {
  name = "${var.tags["Project"]}-${var.tags["Environment"]}-exec-lambda"

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

resource "aws_iam_role_policy_attachment" "s3_policy_lambda_attachment" {
  role       = aws_iam_role.exec_role.name
  policy_arn = aws_iam_policy.s3_lambda.arn
}

data "aws_s3_bucket" "target_bucket" {
  bucket = var.s3_lambda_event_target_bucket
}

resource "aws_iam_policy" "s3_lambda" {
  name        = "${var.tags["Project"]}-${var.tags["Environment"]}-s3-lambda"
  description = "S3 policy allowing operations on lambda target bucket"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action": "s3:ListAllMyBuckets",
         "Resource":"arn:aws:s3:::*"
      },
      {
         "Effect":"Allow",
         "Action":["s3:ListBucket","s3:GetBucketLocation"],
         "Resource":"arn:aws:s3:::*"
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:GetObjectTagging",
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:PutObjectTagging"
         ],
         "Resource": [
            "${data.aws_s3_bucket.source_bucket.arn}/*",
            "${data.aws_s3_bucket.target_bucket.arn}/*"
          ]
      }
   ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cw_logs_lambda" {
  role       = aws_iam_role.exec_role.name
  policy_arn = aws_iam_policy.cw_logs.arn
}

resource "aws_iam_policy" "cw_logs" {
  name        = "${var.tags["Project"]}-${var.tags["Environment"]}-cw-logs"
  description = "CloudWatch policy allowing logs storage"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
         ],
         "Resource": "arn:aws:logs:*:*:*"
      }
   ]
}
EOF
}