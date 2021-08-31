# Update the variables according to your requirement!

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.61.0"
    }
  }
}

variable "project_name" {
  description = "Project Name - will prefix all generated AWS resource names"
  default     = "tgwlab"
}

provider "aws" {
  profile = "default"
  region  = var.region
  access_key = "your_key"
  secret_key = "your secret key"
}

variable "region" {
  default = "your_region"
}

data "aws_availability_zones" "azs" {
}

variable "edge_sg_vpc_cidr" {
  description = "Edge VPC CIDR"
  default = "10.7.0.0/16"
}

variable "spoke_1_sg_vpc_cidr" {
  description = "Spoke VPC 1 CIDR"
  default = "10.10.0.0/16"
}

variable "spoke_2_sg_vpc_cidr" {
  description = "Spoke VPC 2 CIDR"
  default = "10.20.0.0/16"
}

variable "key_name" {
  description = "SSH Key Pair"
  default = "your_key"
}

variable "ubuntu_20_ami_sg" {
  description = "Ubuntu AMI ID 18.04 "
  default = "your_amiID"
}
