variable "private_subnet_cidrs"{
    type = list(string)
    default = ["10.0.101.0/24","10.0.102.0/24"]
}

variable "availability_zones" {
    type = list(string)
    default = ["us-east-1a","us-east-1b"]
}

variable "db_password" {
    description = "Master password for the RDS instance"
    type = string
    sensitive = true
}