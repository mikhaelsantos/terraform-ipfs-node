variable "name" {
  description =  " name"
  default = "ipfs"
}
variable "env" {
  description =  "Enviroment acroynm"
  default = "IPFST"
}
variable "enviroment" {
  description =  "Enviroment"
  default = "ipfs-test"
}

variable "vpc_id" {
}


variable "image_id" {
  description =  "Image id to use on the instance"
  default = "ami-f90a4880"
}
variable "key_name" {
}
variable "subnets" {
  type = "list"
  description =  "Deployment subnets"
}
variable "cluster" {
  type    = "map"
  default = {
    "max" = 2
    "min" = 1
    "desired" = 1
    "instance_type" = "t3.micro"
  }
}

variable "ingress_rules" {
  type = "list"
}

variable "path_to_init" {
}
variable "path_to_policy" {
}
variable "path_to_assume_policy" {
}



