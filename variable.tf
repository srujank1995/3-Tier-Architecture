// Define the variables you'll use in your Terraform scripts.

variable "region" {
  description = "AWS region to deploy resources"
  default = "eu-north-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  default = "10.0.2.0/24"
}

variable "db_subnet_cidr" {
    description = "CIDR block for db subnet"
    default = "10.0.3.0/24"
}

variable "db_username" {
    description = "Database username"
    default = "admin"
}

variable "db_password" {
  description = "database password"
  default = "password"
}

variable "key_pair" {
  description = "Name of the SSH key pair"
  default     = "dev-Project-key"
}