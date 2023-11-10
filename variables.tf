variable "AWS_ACCESS_KEY_ID" {
  type = string 
}
variable "AWS_SECRET_ACCESS_KEY" {
  type = string 
}
variable "AWS_REGION" {
  type = string
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
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "bostion_subnet" {
  type = string
}
variable "availability_zones" {
  type = list(string)
}

variable "db_username" {
  type = string
}
variable "db_password"{
  type = string
}