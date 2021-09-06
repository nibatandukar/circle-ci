variable "enable" {
  type        = bool
  description = "Create or not the resources"
  default     = true
}


variable "region" {
  type = string
  description = "AWS region where to create resources"
  default = "us-east-1"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
  default = {
    Environment = "dev",
  }
}

variable "vpc_cidr_block" {
  type        = string
  description = "The VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
  default     = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets"
  default     = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}
