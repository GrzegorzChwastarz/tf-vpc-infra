resource "aws_s3_bucket_object" "object" {
  count  = aws_s3_bucket.this.bucket == var.artifacts_bucket_name ? 1 : 0
  bucket = aws_s3_bucket.this.bucket
  key    = "s3sync_2.26_Linux_x86_64.tar"
  source = "${path.root}/packages/s3sync_2.26_Linux_x86_64.tar"
}
