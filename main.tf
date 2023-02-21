resource "aws_s3_object" "object" {
  bucket = var.bucket_name
  key    = var.object_key
  source = var.object_source_path

  etag = filemd5(var.object_source_path)
}