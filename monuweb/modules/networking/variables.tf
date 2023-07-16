variable "virtual_network_name" {}

variable "address_space" {}

variable "subnets" {
  type = list(object({
    name   = string
    prefix = string
  }))
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type = string
}
variable "resource_group_location" {
  description = "Location of the resource group"
  type = string
}