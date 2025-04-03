variable "cidr_blocks" {
    default = ["0.0.0.0/0"]
}

variable "protocol" {
    default = "tcp"
}

variable "security_group_name" {}

variable "security_group_ports" {}