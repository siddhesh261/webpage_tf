terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_page" {
  ami           = "ami-02d7fd1c2af6eead0" 
  instance_type = "t2.micro"
  key_name                    = "terra1"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.webpage_security_group.id]
  user_data                   = file("webpage_install.sh")

  tags = {
    Name = "Webpage"
  }
  
}

resource "aws_security_group" "webpage_security_group" {
  name        = "webpage_security_group"
  description = "Allows Port SSH and HTTP Traffic"

  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 8080 Traffic"
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*resource "aws_s3_bucket" "my_s3_bucketss" {
  bucket = "Webpage-s3-bucket-hghgbfggvg"

  tags = {
    Name = "webpage S3 Bucket"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_aclll" {
  bucket = aws_s3_bucket.my_s3_bucketss.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownerships]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownerships" {
  bucket = aws_s3_bucket.my_s3_bucketss.id
  rule {
    object_ownership = "ObjectWriter"
  }
}*/

