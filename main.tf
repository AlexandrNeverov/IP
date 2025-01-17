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

provider "aws" {
  region     = "us-east-1"          
  access_key = file ("/home/ubuntu/terraform/projects/s1.tfvars")      
  secret_key = file ("/home/ubuntu/terraform/projects/s1.tfvars")      
}

resource "aws_key_pair" "MKP" {
    key_name = "MKP"
    public_key = file ("/home/ubuntu/.ssh/id_ed25519.pub")
}

resource "aws_instance" "dev_infrapro" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    key_name = "MKP"
  
}

tags = {
  Name = "Dev_IP"
}