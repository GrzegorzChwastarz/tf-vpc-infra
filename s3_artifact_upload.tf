resource "aws_s3_bucket_object" "object" {
  bucket = var.s3_buckets.s3_artifacts.s3_bucket_name
  key    = "s3sync_2.26_Linux_x86_64.tar"
  source = "${path.root}/packages/s3sync_2.26_Linux_x86_64.tar"
}