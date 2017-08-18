resource "alicloud_slb" "instance" {
  name = "testslb"
  internet_charge_type = "paybytraffic"
  internet = "true"

  listener = [
    {
      "instance_port" = "8080"
      "lb_port" = "80"
      "lb_protocol" = "tcp"
      "bandwidth" = "5"
    }]
}


resource "alicloud_slb_attachment" "default" {
  slb_id = "${alicloud_slb.instance.id}"
  instances = ["${alicloud_instance.test.*.id}"]
}
