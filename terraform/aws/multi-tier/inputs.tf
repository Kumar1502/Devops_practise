variable "primary_network_cidr" {
  type        = string
  description = "this is primary network cidr"
  default     = "11.0.0.0/16"
}

variable "region" {
  type        = string
  description = "this is region "
  default     = "eastus"
}

variable "resource_group" {
  type        = string
  description = "this is resource group"
  default     = "myresource"
}
variable "subnet_names" {
  type        = list(string)
  description = "this is subnet names"
  default     = ["db_01", "web_01", "app_01", "db_02", "web_02", "app_02"]

}
variable "subnet_cidrs" {
  type        = list(string)
  description = "this is subnet group"
  default     = ["11.0.0.0/24", "11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24", "11.0.4.0/24", "11.0.5.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "this is availability zones"
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1a", "ap-south-1b", "ap-south-1a", "ap-south-1b"]
}
