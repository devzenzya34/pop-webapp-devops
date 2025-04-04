resource "aws_instance" "ec2_pop_project_docker" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = ["${var.security_groups_name}"]
  associate_public_ip_address = true
  root_block_device {
    volume_size = 20
    volume_type = "gp2"
    encrypted = true
    delete_on_termination = true
  }
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = var.username
      host = self.public_ip
      private_key = file(var.private_key_path)
    }
    script = "./scripts/install_docker.sh"
  }
  tags = {
    Name = var.instance_name
  }
}

