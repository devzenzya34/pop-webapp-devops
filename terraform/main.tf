data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    owners = ["099720109477"] # Canonical
}

locals {
  ami_id = data.aws_ami.ubuntu.id
  filename = "./keypair/${var.stack_name}.pem"
  instance_name = "var.stack_name"
}

module "keypair" {
  source = "./modules/keypair"
  key_name = var.stack_name
  filemane = local.filename
}

module "security_groups" {
  source = "modules/security_group"
  protocol = var.protocol
  security_groups_name = var.security_groups_name
  security_groups_ports = var.security_groups_ports
  depends_on = [ module.keypair ]
}

module "ec2_docker" {
  source               = "./modules/docker"
  ami                  = local.ami_id
  key_name             = var.stack_name
  private_key_path     = local.filename
  username             = var.username
  security_groups_name = module.security_groups.sg_name
  instance_name        = local.instance_name
  instance_type        = var.instance_type
  count                = var.stack_name == "docker" ? 1 : 0
  depends_on = [ module.keypair ]
}
module "ec2_kubernetes" {
  source               = "./modules/kubernetes"
  ami                  = local.ami_id
  key_name             = var.stack_name
  private_key_path     = local.filename
  username             = var.username
  security_groups_name = module.security_groups.sg_name
  instance_name        = local.instance_name
  instance_type        = var.instance_type
  count                = var.stack_name == "kubernetes" ? 1 : 0
  depends_on = [ module.keypair ]
}
