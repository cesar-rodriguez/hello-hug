terraform {
  backend "s3" {
    bucket         = "therasec-state-bucket"
    region         = "us-east-1"
    encrypt        = "true"
    acl            = "private"
    dynamodb_table = "therasec-state-bucket"
    profile        = "therasec-prod"
  }
}

variable "environment" {}
variable "vpc_id" {}

provider "aws" {
  profile = "${var.environment}"
  region  = "us-east-1"
}

resource "aws_security_group" "web_sg" {
  name        = "web"
  description = "Security group for web server"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "id" {
  value = "${aws_security_group.web_sg.id}"
}
