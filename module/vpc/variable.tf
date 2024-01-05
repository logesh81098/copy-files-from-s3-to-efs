variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "project-name" {
  default = "S3-to-EFS"
}

variable "private-subnet-1-cidr-block" {
  default = "10.0.1.0/24"
}

variable "private-subnet-2-cidr-block" {
  default = "10.0.2.0/24"
}