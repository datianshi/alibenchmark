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
variable "count" {
  default = "1"
}


# For RDS

variable "engine" {
  default = "MySQL"
}
variable "engine_version" {
  default = "5.6"
}
variable "instance_class" {
  default = "rds.mysql.t1.small"
}
variable "storage" {
  default = "10"
}
variable "net_type" {
  default = "Intranet"
}

variable "rds_user_name" {
  default = "tf_tester"
}
variable "rds_password" {
  default = "Test12345"
}

variable "database_name" {
  default = "sdingtest"
}
variable "database_character" {
  default = "utf8"
}
