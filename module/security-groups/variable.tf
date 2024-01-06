variable "vpc-id" {
    default = {}
}

variable "project-name" {
  default = "s3-to-efs"
}

variable "subnet1-cidr" {
  default = "10.0.1.0/24"
}
variable "subnet2-cidr" {
  default = "10.0.2.0/24"
}
