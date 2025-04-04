security_groups_ports = [22, 80, 8080, 8069, 30080, 30010, 30011]

security_groups_name = "sg_pop_project"

instance_type = "t2.medium"

username = "ubuntu"

protocol = "tcp"

# key_name = "keypair_pop_project"

region = "us-east-1"

stack_name = "kubernetes" # docker or kubernetes