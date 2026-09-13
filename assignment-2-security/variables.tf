variable "my_ip" {
    description = "Your public IP in CIDR notation, for SSH access"
    type = string
    # set in terraform.tfvars, do not hardcode here
}