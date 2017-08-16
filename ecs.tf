# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

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

resource "alicloud_instance" "test" {
  provider          = "alicloud"
  availability_zone = "${var.zone}"
  image_id          = "${var.image}"

  password = "${var.ecs_password}"
  key_name = "${var.key_name}"
  count = "${var.count}"
  internet_charge_type = "PayByTraffic"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"
  instance_type        = "${var.instance_type}"
  system_disk_category = "${var.disk_category}"
  security_groups      = ["${alicloud_security_group.default.id}"]
  instance_name        = "test"
  instance_charge_type = "PostPaid"
  allocate_public_ip = "true"
  vswitch_id = "${alicloud_vswitch.main.id}"
  tags {
    name = "test"
  }
}

resource "alicloud_disk" "disk" {
  availability_zone = "${alicloud_instance.test.0.availability_zone}"
  category = "${var.disk_category}"
  size = "${var.disk_size}"
  count = "1"
}

resource "alicloud_disk_attachment" "instance-attachment" {
  count = "${var.disk_count}"
  disk_id = "${element(alicloud_disk.disk.*.id, count.index)}"
  instance_id = "${element(alicloud_instance.test.*.id, count.index%var.count)}"
}


resource "alicloud_security_group_rule" "allow_https_22" {
  type = "ingress"
  ip_protocol = "tcp"
  nic_type = "intranet"
  policy = "accept"
  port_range = "22/22"
  priority = 1
  security_group_id = "${alicloud_security_group.default.id}"
  cidr_ip = "0.0.0.0/0"
}

# Create security group
resource "alicloud_security_group" "default" {
  name        = "default"
  provider    = "alicloud"
  description = "default"
  vpc_id = "${alicloud_vpc.main.id}"
}
