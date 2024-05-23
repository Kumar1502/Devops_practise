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

security_group_info = {
  name        = "web"
  vpc_id      = ""
  description = "rule for web server"
  inbound_rules = [{
    cidr        = "0.0.0.0/0"
    port        = 22
    protocol    = "tcp"
    description = "open ssh"

    }, {
    cidr        = "0.0.0.0/0"
    port        = 80
    protocol    = "tcp"
    description = "open http"

  }]
  outbound_rules   = []
  allow_all_egress = true
}
web_instance_info = {
  ami               = "ami-05e00961530ae1b55"
  security_group_id = ""
  subnet_id         = ""
  size              = "t2.micro"
  key_name          = "newkeypair"
  name              = "web"
}
