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
  user_data = "${file("initiate.sh")}"
  tags {
    name = "test"
  }
}

resource "alicloud_disk" "disk" {
  availability_zone = "${alicloud_instance.test.0.availability_zone}"
  category = "${var.disk_category}"
  size = "${var.disk_size}"
  count = "${var.count}"
}

resource "alicloud_disk_attachment" "instance-attachment" {
  count = "${var.count}"
  disk_id = "${element(alicloud_disk.disk.*.id, count.index)}"
  instance_id = "${element(alicloud_instance.test.*.id, count.index%var.count)}"
}
