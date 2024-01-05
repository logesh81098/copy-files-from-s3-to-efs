###########################################################################################################
#                                     Creating VPC
###########################################################################################################
resource "aws_vpc" "s3-to-efs-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "${var.project-name}-VPC"
  }
}

###########################################################################################################
#                                     Creating Subnets
###########################################################################################################
resource "aws_subnet" "private-subnet-1" {
  vpc_id = aws_vpc.s3-to-efs-vpc.id
  cidr_block = var.private-subnet-1-cidr-block
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.project-name}-Private-Subnet-1"
  }
}


resource "aws_subnet" "private-subnet-2" {
  vpc_id = aws_vpc.s3-to-efs-vpc.id
  cidr_block = var.private-subnet-2-cidr-block
  tags = {
    Name = "${var.project-name}-Private-Subnet-2"
  }
}

###########################################################################################################
#                                     Creating Route Table
###########################################################################################################
resource "aws_route_table" "s3-to-efs-route-table" {
  vpc_id = aws_vpc.s3-to-efs-vpc.id
  tags = {
    Name = "${var.project-name}-Route-table"
  }
}

###########################################################################################################
#                                    Route Table Association
###########################################################################################################
resource "aws_route_table_association" "subnet1" {
  subnet_id = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.s3-to-efs-route-table.id
}

resource "aws_route_table_association" "subnet-2" {
  subnet_id = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.s3-to-efs-route-table.id
}


###########################################################################################################
#Number of Resource: 6
###########################################################################################################