data "template_file" "zk_userdata_1" {
  template = "${file("${path.module}/scripts/zookeeper.tpl")}"
  vars {
    index = 1
  }
}

data "template_file" "zk_userdata_2" {
  template = "${file("${path.module}/scripts/zookeeper.tpl")}"
  vars {
    index = 2
  }
}

data "template_file" "zk_userdata_3" {
  template = "${file("${path.module}/scripts/zookeeper.tpl")}"
  vars {
    index = 3
  }
}

resource "aws_instance" "zk_1" {
  tags {
    Name = "ZK-1"
  }
  ami = "ami-085d69987e6675f08"
  instance_type = "m4.large"
  subnet_id = "${var.subnet_private_1}"
  vpc_security_group_ids = ["${aws_security_group.zk_server.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = true
  }

  user_data = "${data.template_file.zk_userdata_1.rendered}"
  key_name = "${var.key}"
}

output "ZK 1 IP:" {
  value = "${aws_instance.zk_1.private_ip}"
}

resource "aws_instance" "zk_2" {
  tags {
    Name = "ZK-2"
  }

  ami = "ami-085d69987e6675f08"
  instance_type = "m4.large"
  subnet_id = "${var.subnet_private_2}"
  vpc_security_group_ids = ["${aws_security_group.zk_server.id}"]
  ebs_optimized = true
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "gp2"
    volume_size = 100
    delete_on_termination = true
  }
  user_data = "${data.template_file.zk_userdata_2.rendered}"
  key_name = "${var.key}"
}

output "ZK 2 IP:" {
  value = "${aws_instance.zk_2.private_ip}"
}

resource "aws_instance" "zk_3" {
  tags {
    Name = "ZK-3"
  }
  ami = "ami-085d69987e6675f08"
  instance_type = "${var.zk_instance_type}"
  subnet_id = "${var.subnet_private_3}"
  vpc_security_group_ids = ["${aws_security_group.zk_server.id}"]

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

  user_data = "${data.template_file.zk_userdata_3.rendered}"
  key_name = "${var.key}"
}

output "ZK 3 IP:" {
  value = "${aws_instance.zk_3.private_ip}"
}
