terraform {
    required_version = ">= 1.0.0"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.0"}
        http = {
            source  = "hashicorp/http"
            version = ">= 2.1.0"}
        random = {
            source = "hashicorp/random"
            version = ">= 3.1.0"}
        local = {
            source = "hashicorp/local"
            version = ">=2.1.0"}
        tls = {
            source  = "hashicorp/tls"
            version = ">= 3.1.0"
        }
    }
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

provider "aws" {
  region     = "us-east-1"          
  access_key = var.aws_access_key    
  secret_key = var.aws_secret_key      
}

resource "aws_key_pair" "MKP" {
    key_name = "MKP"
    public_key = file ("/home/ubuntu/.ssh/id_ed25519.pub")
}

resource "aws_instance" "dev_infrapro" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "MKP"
    security_group_ids = ["launch-wizard-1"]


  tags = {
        Name = "Dev_IP"
      }
    

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y ansible",
      "ansible-playbook /home/ubuntu/terraform/projects/IP/ansible/jenkins_pl.yaml"
    ]
  }
}