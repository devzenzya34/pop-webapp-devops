data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-22.04-amd64-server-*"]
    }
    owners = ["099720109477"] # Canonical
}

locals {
  ami_id = data.aws_ami.ubuntu.id
  filename = "./keypair/${var.key_name}.pem"
  instance_name = "var.stack_name"
}

module "keypair" {
  source = "./modules/keypair"
  key_name = var.key_name
  filemane = local.filename
}

module "security_groups" {
  source = "modules/security_group"
  protocol = var.protocol
  security_groups_name = var.security_groups_name
  security_groups_ports = var.security_groups_ports
}

module "ec2" {
  source = "./modules/${var.stack_name}"
  ami = local.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups_name = module.security_groups.sg_name
  username = var.username
  private_key_path = local.filename
  instance_name = local.instance_name
}
