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
variable "security_group_info" {
  type = object({
    name        = string
    vpc_id      = string
    description = string
    inbound_rules = list(object({
      cidr        = string
      port        = number
      protocol    = string
      description = string
    }))
    outbound_rules = list(object({
      cidr        = string
      from_port   = number
      to_port     = number
      protocol    = string
      description = string
    }))
    allow_all_egress = bool
  })
  description = "security group info"
}
variable "web_instance_info" {
  type = object({
    name              = string
    size              = string
    ami               = string
    subnet_id         = string
    security_group_id = string
    key_name          = string
  })
}
