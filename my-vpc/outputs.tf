output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "private_subnet_ids"{
    value = aws_subnet.private_subnet[*].id
}
output "my_vpc"{
    value = aws_vpc.my_vpc.id
}
output "bostion_subnet" {
    value = aws_subnet.bostion_subnet.id
}