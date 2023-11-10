variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "my_vpc_id" {
  type = string
}
variable "availability_zones" {
  type = list(string)
}
variable "instance_type" {
  type = string
}
variable "image_id" {
  type = string
}
variable "key_name" {
  type = string
}
variable "db_user_name" {
 type = string 
}
variable "db_password" {
  type = string
}