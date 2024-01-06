output "vpc-id" {
  value = aws_vpc.s3-to-efs-vpc.id
}

output "subnet-1-id" {
  value = aws_subnet.private-subnet-1.id
}

output "subnet-2-id" {
  value = aws_subnet.private-subnet-2.id
}
