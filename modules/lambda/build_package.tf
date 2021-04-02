resource "local_file" "lambda_source" {
  filename = "${path.root}/scripts/lambda_s3_event.py"
  content = templatefile("${path.module}/lambda_s3_event.tpl",
  {
    s3_lambda_event_target = var.s3_lambda_event_target_bucket
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