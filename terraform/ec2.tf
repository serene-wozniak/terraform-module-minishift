resource "aws_instance" "minishift" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  subnet_id              = "${element( var.subnets, count.index % length(var.subnets))}"
  vpc_security_group_ids = ["${aws_security_group.minishift-access.id}"]
  count                  = "1"

  tags {
    Name   = "${var.minishift-name}-minishift"
    Domain = "${var.domain}"
    Role   = "Openshift All in One Server"
  }

  iam_instance_profile = "${var.instance_profile_id}"
  user_data            = "${module.minishift.cloud_init_config}"
}

module "minishift_bootstrap" {
  source              = "git@github.com:serene-wozniak/terraform-module-bootstrap.git//ansible_bootstrap?ref=v0.0.1"
  ansible_source_repo = "git@github.com:serene-wozniak/terraform-module-minishift.git"
  ansible_role        = "mini-openshift"

  ansible_facts = {}

  ssh_ca_publickey      = "${var.ssh_user_ca_publickey}"
  github_ssh_privatekey = "${var.git_private_key}"
}