data "template_file" "zk_userdata" {
  count = "${var.zk_count}"
  template = "${file("${path.module}/scripts/zookeeper.tpl")}"
  vars {
    index = "${count.index + 1}"
  }
}

resource "aws_instance" "zookeeper" {
  count = "${var.zk_count}"
  tags {
    Name = "ZK-${count.index + 1}"
    Index = "${count.index + 1}"
  }
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "${var.zk_instance_type}"
  subnet_id = "${element(var.subnets, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.zk_kafka_cluster.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "gp2"
    volume_size = "${var.zk_volume_size}"
    delete_on_termination = true
  }

  user_data = "${element(data.template_file.zk_userdata.*.rendered, count.index)}"
  key_name = "${var.key}"
}

data "template_file" "zk_conf" {
  template = "${file("${path.module}/scripts/zoo.cfg.tpl")}"
  vars {
    serverList = "${join("\n", formatlist("server.%s=%s:2888:3888", aws_instance.zookeeper.*.tags.Index , aws_instance.zookeeper.*.private_ip))}"
  }
}

resource "null_resource" "zk_conf_upload" {
  count = "${var.zk_count}"
  triggers {
    cluster_instance_ids = "${join(",", aws_instance.zookeeper.*.id)}"
  }

  provisioner "file" {
    destination = "/tmp/zoo.cfg"
    content = "${data.template_file.zk_conf.rendered}"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file(var.private_key)}"
    host = "${element(aws_instance.zookeeper.*.private_ip, count.index)}"
    bastion_host = "${var.bastion_public_host}"
    bastion_private_key = "${file(var.bastion_private_key)}"
    bastion_user = "${var.bastion_username}"
  }
}

output "Zookeeper List:" {
  value = "${join(",", formatlist("%s:2181", aws_instance.zookeeper.*.private_ip))}"
}

