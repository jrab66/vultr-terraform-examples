variable "vultr_api_key" {}

variable "instance_name" {
    default = "vultrvps"
}
variable "vultr_region"  {
  default = "Toronto"
}
variable "os_version"  {
  default = "Ubuntu 18.04 x64"
}
variable "plan"  {
  type = "list"
  // [price, ram ]
  default = ["5.00","1024"]
}
