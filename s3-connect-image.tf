data "template_file" "s3_connect_properties" {
  count = "${var.kafka_count}"
  template = "${file("${path.module}/scripts/connect-standalone.properties.tpl")}"
  vars {
    kafkaList = "${join(",", formatlist("%s:9092", aws_instance.kafka.*.private_ip))}"
  }
}

//resource "null_resource" "create" {}
