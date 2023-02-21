terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55"
    }
  }
}
provider "aws" {
  region = var.region_name
}
variable "region_name" {
  description = "region of AWS to create S3 bucket"
  default = "us-east-1"
  type = string
}
variable "bucket_name" {
  description = "Name of the S3 Bucket"
  type = string
}
variable "index_file_name" {
  description = "index file to serve the website"
  type = string
}
variable "source_path" {
  description = "Path to the static html file"
  type = string
}

# Creating S3 bucket
resource "aws_s3_bucket" "demobucket" {
  bucket = var.bucket_name
}

# Enabling static website hosting for S3 bucket
resource "aws_s3_bucket_website_configuration" "demowebsite" {
  bucket =  aws_s3_bucket.demobucket.id
  index_document {
    suffix = var.index_file_name
  }
}

#uploading html file to S3 bucket
resource "aws_s3_object" "demoobject" {
  bucket = aws_s3_bucket.demobucket.bucket
  key = var.index_file_name
  source = var.source_path
  content_type = "text/html"
  etag =  filemd5(var.source_path)
}
#Creating bucket policy to allow public access
resource "aws_s3_bucket_policy" "name" {
  bucket = aws_s3_bucket.demobucket.id
  policy = data.aws_iam_policy_document.policydoc.json
}
data "aws_iam_policy_document" "policydoc" {
  statement {
    principals {
      type = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      aws_s3_bucket.demobucket.arn,
      "${aws_s3_bucket.demobucket.arn}/*"
    ]
  }
}

#Turning off block public access settings at bucket level
resource "aws_s3_bucket_public_access_block" "accessblock" {
  bucket = aws_s3_bucket.demobucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# This will write the deployed website URL
output "websiteURL" {
  description = "Deployed website URL"
  value = "You can access the website at following URL http://${aws_s3_bucket_website_configuration.demowebsite.website_endpoint}/index.html. Please make sure that S3 Block Public Access settings are turned off at account level, otherwise website is not accessible to the public"
}
