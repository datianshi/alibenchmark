variable "access_key" {}
variable "secret_key" {}
variable "key_name" {}
variable "region" {
  default = "us-east-1"
}
variable "zone" {
  default = "us-east-1a"
}
variable "image" {
  default = "ubuntu_16_0402_64_40G_alibase_20170711.vhd"
}
variable "instance_type" {
  default = "ecs.n4.small"
}
variable "ecs_password" {
  default = "Test12345"
}
variable "internet_max_bandwidth_out" {
  default = "2"
}

variable "disk_category" {
  default = "cloud_efficiency"
}

variable "disk_size" {
  default = "40"
}

variable "disk_count" {
  default = "1"
}
