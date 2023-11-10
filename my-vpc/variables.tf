variable "public_subnet_list" {
  type = list(string)
}
variable "private_subnet_list" {
    type = list(string)
}
variable "availability_zone" {
  type = list(string)
}
variable "bostion_subnet" {
  type = string
}