variable "network_info" {
  type = object({
    name       = string
    cidr_range = string
  })

}

variable "public_subnets" {
  type = list(object({
    name        = string
    subnet_cidr = string
    az          = string


  }))
  description = "public subnets"
}

variable "private_subnets" {
  type = list(object({
    name        = string
    subnet_cidr = string
    az          = string


  }))
  description = "private subnets"
}
