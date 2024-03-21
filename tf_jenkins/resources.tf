
/*EC2 instance provisioning*/
resource "aws_instance" "jenkins_ec2" {
  ami           = "ami-0d7a109bf30624c99" 
  instance_type = "t2.micro"
  key_name                    = "terra1"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.jenkins_security_group.id]
  user_data                   = file("jenkins_install.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}

/* For setting inbound and outbound traffic*/
resource "aws_security_group" "jenkins_security_group" {
  name        = "jenkins_security_group"
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

/*resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "jenkins-s3-bucket-12347342gfe8dsf"

  tags = {
    Name = "Jenkins S3 Bucket"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}*/