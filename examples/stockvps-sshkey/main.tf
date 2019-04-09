
provider "vultr" {
    api_key = "${var.vultr_api_key}"
}

data "vultr_region" "region" {
  filter {
    name   = "name"
    values = ["${var.vultr_region}"]
  }
}

data "vultr_os" "os" {
  filter {
    name   = "name"
    values = ["${var.os_version}"]
  }
}

data "vultr_plan" "plan" {
  filter {
    name   = "price_per_month"
    values = ["${var.plan[0]}"]
  }

  filter {
    name   = "ram"
    values = ["${var.plan[1]}"]
  }
}
# only using ssh_key
# data "vultr_ssh_key" "squat" {
#   filter {
#     name   = "name"
#     values = ["terraform_infra"]
#   }
# }

#creating ssh_key
resource "vultr_ssh_key" "terraform_infra" {
  name       = "terraform_infra"
  public_key = "${var.pub_key}"
}
resource "vultr_instance" "intance" {
  name              = "${var.instance_name}"
  region_id         = "${data.vultr_region.region.id}"
  plan_id           = "${data.vultr_plan.plan.id}"
  os_id             = "${data.vultr_os.os.id}"
  hostname          = "${var.instance_name}"
  ssh_key_ids       = ["${vultr_ssh_key.terraform_infra.id}"]
  # ssh_key_ids = [
  #   "${var.ssh_fingerprint}",
  # ]
  connection {
    user        = "root"
    type        = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout     = "2m"
  }

}
