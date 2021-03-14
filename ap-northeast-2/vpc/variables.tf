
variable "resource_name" {
  type    = string
  default = "myresource-terraform"
}
variable "vpc_cidr" {
  type    = string
  default = "172.31.0.0/16"
}
variable "sub_pub2a_cidr" {
  type    = string
  default = "172.31.0.0/24"
}
variable "sub_pub2c_cidr" {
  type    = string
  default = "172.31.1.0/24"
}
variable "sub_pri2a_cidr" {
  type    = string
  default = "172.31.2.0/24"
}
variable "sub_pri2c_cidr" {
  type    = string
  default = "172.31.3.0/24"
}
