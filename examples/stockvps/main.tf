
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


resource "vultr_instance" "intance" {
  name              = "${var.instance_name}"
  region_id         = "${data.vultr_region.region.id}"
  plan_id           = "${data.vultr_plan.plan.id}"
  os_id             = "${data.vultr_os.os.id}"
  hostname          = "${var.instance_name}"
}
