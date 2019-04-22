data "template_file" "zk_1_config" {
  template = "${file("${path.module}/scripts/zoo.conf.tpl")}"
  vars {
    server1_ip = "${aws_instance.zk_1.private_ip}"
    server2_ip = "${aws_instance.zk_2.private_ip}"
    server3_ip = "${aws_instance.zk_3.private_ip}"
  }
}


data "template_file" "zk_2_config" {
  template = "${file("${path.module}/scripts/zoo.conf.tpl")}"
  vars {
    server1_ip = "${aws_instance.zk_1.private_ip}"
    server2_ip = "${aws_instance.zk_2.private_ip}"
    server3_ip = "${aws_instance.zk_3.private_ip}"
  }
}

data "template_file" "zk_3_config" {
  template = "${file("${path.module}/scripts/zoo.conf.tpl")}"
  vars {
    server1_ip = "${aws_instance.zk_1.private_ip}"
    server2_ip = "${aws_instance.zk_2.private_ip}"
    server3_ip = "${aws_instance.zk_3.private_ip}"
  }
}

resource "null_resource" "zk_1_remote" {
  triggers {
    cluster_instance_ids = "${aws_instance.zk_1.id}"
  }

  provisioner "file" {
    destination = "/tmp/zoo.conf"
    content = "${data.template_file.zk_1_config.rendered}"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/aws.pem")}"
    host = "${aws_instance.zk_1.private_ip}"
    bastion_host = "${var.bastion_host}"
    bastion_private_key = "${file("~/.ssh/aws.pem")}"
    bastion_user = "${var.bastion_username}"
  }
}

resource "null_resource" "zk_2_remote" {
  triggers {
    cluster_instance_ids = "${aws_instance.zk_2.id}"
  }

  provisioner "file" {
    destination = "/tmp/zoo.conf"
    content = "${data.template_file.zk_2_config.rendered}"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/aws.pem")}"
    host = "${aws_instance.zk_2.private_ip}"
    bastion_host = "${var.bastion_host}"
    bastion_private_key = "${file("~/.ssh/aws.pem")}"
    bastion_user = "${var.bastion_username}"
  }
}

resource "null_resource" "zk_3_remote" {
  triggers {
    cluster_instance_ids = "${aws_instance.zk_3.id}"
  }

  provisioner "file" {
    destination = "/tmp/zoo.conf"
    content = "${data.template_file.zk_3_config.rendered}"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file("~/.ssh/aws.pem")}"
    host = "${aws_instance.zk_3.private_ip}"
    bastion_host = "${var.bastion_host}"
    bastion_private_key = "${file("~/.ssh/aws.pem")}"
    bastion_user = "${var.bastion_username}"
  }
}
