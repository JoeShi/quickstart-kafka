//data "template_file" "kafka_bootstrap_1" {
//  template = "${file("${path.module}/scripts/kafka.config.tpl")}"
//  vars {
//    broker_id = 1
//    zookeeper_1_ip = "${aws_instance.zk_1.private_ip}"
//    zookeeper_2_ip = "${aws_instance.zk_2.private_ip}"
//    zookeeper_3_ip = "${aws_instance.zk_3.private_ip}"
//  }
//}
//
//data "template_file" "kafka_bootstrap_2" {
//  template = "${file("${path.module}/scripts/kafka.config.tpl")}"
//  vars {
//    broker_id = 2
//    zookeeper_1_ip = "${aws_instance.zk_1.private_ip}"
//    zookeeper_2_ip = "${aws_instance.zk_2.private_ip}"
//    zookeeper_3_ip = "${aws_instance.zk_3.private_ip}"
//  }
//}
//
//data "template_file" "kafka_bootstrap_3" {
//  template = "${file("${path.module}/scripts/kafka.config.tpl")}"
//  vars {
//    broker_id = 3
//    zookeeper_1_ip = "${aws_instance.zk_1.private_ip}"
//    zookeeper_2_ip = "${aws_instance.zk_2.private_ip}"
//    zookeeper_3_ip = "${aws_instance.zk_3.private_ip}"
//  }
//}
//
//# Zookeeper installation for instance 1
//resource "null_resource" "kafka_1_remote" {
//  triggers {
//    cluster_instance_ids = "${aws_instance.zk_1.id}"
//  }
//
//  provisioner "file" {
//    destination = "/tmp/kafka.sh"
//    content = "${data.template_file.kafka_bootstrap_1.rendered}"
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "cd /tmp",
//      "chmod a+x kafka.sh",
//      "sudo ./kafka.sh"
//    ]
//  }
//
//  connection {
//    type = "ssh"
//    user = "ubuntu"
//    private_key = "${file("~/.ssh/aws.pem")}"
//    host = "${aws_instance.kafka_1.private_ip}"
//    bastion_host = "${var.bastion_host}"
//    bastion_private_key = "${file("~/.ssh/aws.pem")}"
//    bastion_user = "${var.bastion_username}"
//  }
//  depends_on = ["null_resource.zk_1_remote", "null_resource.zk_2_remote", "null_resource.zk_3_remote"]
//}
//
//# Zookeeper installation for instance 2
//resource "null_resource" "kafka_2_remote" {
//  triggers {
//    cluster_instance_ids = "${aws_instance.kafka_2.id}"
//  }
//
//  provisioner "file" {
//    destination = "/tmp/kafka.sh"
//    content = "${data.template_file.kafka_bootstrap_2.rendered}"
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "cd /tmp",
//      "chmod a+x kafka.sh",
//      "sudo ./kafka.sh"
//    ]
//  }
//
//  connection {
//    type = "ssh"
//    user = "ubuntu"
//    private_key = "${file("~/.ssh/aws.pem")}"
//    host = "${aws_instance.kafka_2.private_ip}"
//    bastion_host = "${var.bastion_host}"
//    bastion_private_key = "${file("~/.ssh/aws.pem")}"
//    bastion_user = "${var.bastion_username}"
//  }
//  depends_on = ["null_resource.zk_1_remote", "null_resource.zk_2_remote", "null_resource.zk_3_remote"]
//}
//
//# Zookeeper installation for instance 3
//resource "null_resource" "kafka_3_remote" {
//  triggers {
//    cluster_instance_ids = "${aws_instance.kafka_3.id}"
//  }
//
//  provisioner "file" {
//    destination = "/tmp/kafka.sh"
//    content = "${data.template_file.kafka_bootstrap_3.rendered}"
//  }
//
//  provisioner "remote-exec" {
//    inline = [
//      "cd /tmp",
//      "chmod a+x kafka.sh",
//      "sudo ./kafka.sh"
//    ]
//  }
//
//  connection {
//    type = "ssh"
//    user = "ubuntu"
//    private_key = "${file("~/.ssh/aws.pem")}"
//    host = "${aws_instance.kafka_3.private_ip}"
//    bastion_host = "${var.bastion_host}"
//    bastion_private_key = "${file("~/.ssh/aws.pem")}"
//    bastion_user = "${var.bastion_username}"
//  }
//  depends_on = ["null_resource.zk_1_remote", "null_resource.zk_2_remote", "null_resource.zk_3_remote"]
//}
//
