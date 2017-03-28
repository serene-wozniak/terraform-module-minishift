variable "subnet" {}
variable "vpc_id" {}
variable "ami" {}
variable "instance_type" {}
variable "domain" {}
variable "instance_profile_id" {}
variable "team" {}
variable "name" {}
variable "route53_zone_id" {}
variable "route53_domain" {}

variable "permitted_cidrs" {
  type = "list"
}

# Config Management
variable "ssh_user_ca_publickey" {}
variable "git_private_key" {}
