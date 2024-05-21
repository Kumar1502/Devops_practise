network_info = {
  name       = "ntier"
  cidr_range = "192.168.0.0/16"
}
private_subnets = [{
  name        = "db1"
  subnet_cidr = "192.168.2.0/24"
  az          = "ap-south-1a"
  },
  {
    name        = "db2"
    subnet_cidr = "192.168.3.0/24"
    az          = "ap-south-1b"
}]
public_subnets = [{
  name        = "web1"
  subnet_cidr = "192.168.0.0/24"
  az          = "ap-south-1a"
  },
  {
    name        = "web2"
    subnet_cidr = "192.168.1.0/24"
    az          = "ap-south-1b"
}]
