resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
      Name= "My_vpc"
    }
}
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    count =  length(var.public_subnet_list)
    cidr_block = var.public_subnet_list[count.index]
    availability_zone = var.availability_zone[count.index]
    tags = {
        Name= "public_subnet_${count.index+1}"
    }
    map_public_ip_on_launch = true
}
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    count = length(var.private_subnet_list)
    cidr_block = var.private_subnet_list[count.index]
    availability_zone = var.availability_zone[count.index ]
    
    tags = {
        Name= "private_subnet_${count.index+1}"
    }
}
resource "aws_subnet" "bostion_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.bostion_subnet
  availability_zone = var.availability_zone[0]
}