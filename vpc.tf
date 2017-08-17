resource "alicloud_vpc" "main" {
  name = "vpc-main"
  cidr_block = "10.0.0.0/21"
}

resource "alicloud_vswitch" "main" {
  vpc_id = "${alicloud_vpc.main.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "${var.zone}"
  depends_on = ["alicloud_vpc.main"]
}
