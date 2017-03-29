resource "aws_instance" "minishift" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  subnet_id              = "${var.subnet}"
  vpc_security_group_ids = ["${aws_security_group.minishift-access.id}"]

  tags {
    Name   = "${var.name}-minishift"
    Domain = "${var.domain}"
    Role   = "Openshift All in One Server"
  }

  root_block_device = {
    volume_size = "120"
  }

  iam_instance_profile = "${var.instance_profile_id}"
  user_data            = "${module.minishift_bootstrap.cloud_init_config}"
}

module "minishift_bootstrap" {
  source              = "git@github.com:serene-wozniak/terraform-module-bootstrap.git//ansible_bootstrap?ref=master"
  ansible_source_repo = "git@github.com:serene-wozniak/terraform-module-minishift.git"
  ansible_role        = "minishift"

  ansible_facts = {
    openshift_hostname                  = "minishift${var.name == "" ? "" :  "-${var.name}"}.${var.team}.${var.route53_domain}"
    openshift_oauth_github_clientsecret = "none"
    openshift_oauth_github_clientid     = "none"
    openshift_oauth_github_organisation = "none"
  }

  ssh_ca_publickey      = "${var.ssh_user_ca_publickey}"
  github_ssh_privatekey = "${var.git_private_key}"
}
