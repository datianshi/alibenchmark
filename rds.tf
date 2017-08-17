resource "alicloud_db_instance" "dc" {
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  db_instance_class = "${var.instance_class}"
  db_instance_storage = "${var.storage}"
  db_instance_net_type = "${var.net_type}"

  instance_charge_type = "Postpaid"
  instance_network_type = "VPC"
  vswitch_id = "${alicloud_vswitch.main.id}"
  security_ips = ["127.0.0.1", "${split(",", join(",", alicloud_instance.test.*.private_ip))}"]

  master_user_name = "${var.rds_user_name}"
  master_user_password = "${var.rds_password}"

  depends_on = ["alicloud_instance.test"]

  db_mappings = [{
    db_name = "${var.database_name}"
    character_set_name = "${var.database_character}"
    db_description = "tf"
  }]
}
