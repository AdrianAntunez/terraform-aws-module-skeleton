## Provider block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

# Dummy test
module "test_1" {
  source             = "../"
  bucket_name        = "bucket_name"
  object_key         = "object_key"
  object_source_path = "./object_sample.txt"
}
