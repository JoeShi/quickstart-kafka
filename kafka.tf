data "template_file" "kafka_userdata_1" {
  template = "${file("${path.module}/scripts/kafka.tpl")}"
  vars {
    broker_id = 1
    zookeeper_1_ip = "${aws_instance.zk_1.private_ip}"
    zookeeper_2_ip = "${aws_instance.zk_2.private_ip}"
    zookeeper_3_ip = "${aws_instance.zk_3.private_ip}"
  }
  depends_on = ["aws_instance.zk_1", "aws_instance.zk_2", "aws_instance.zk_3"]
}

data "template_file" "kafka_userdata_2" {
  template = "${file("${path.module}/scripts/kafka.tpl")}"
  vars {
    broker_id = 2
    zookeeper_1_ip = "${aws_instance.zk_1.private_ip}"
    zookeeper_2_ip = "${aws_instance.zk_2.private_ip}"
    zookeeper_3_ip = "${aws_instance.zk_3.private_ip}"
  }
  depends_on = ["aws_instance.zk_1", "aws_instance.zk_2", "aws_instance.zk_3"]
}

data "template_file" "kafka_userdata_3" {
  template = "${file("${path.module}/scripts/kafka.tpl")}"
  vars {
    broker_id = 3
    zookeeper_1_ip = "${aws_instance.zk_1.private_ip}"
    zookeeper_2_ip = "${aws_instance.zk_2.private_ip}"
    zookeeper_3_ip = "${aws_instance.zk_3.private_ip}"
  }
  depends_on = ["aws_instance.zk_1", "aws_instance.zk_2", "aws_instance.zk_3"]
}

resource "aws_instance" "kafka_1" {
  tags {
    Name = "Kafka-1"
  }
  ami = "ami-085d69987e6675f08"
  instance_type = "m4.large"
  subnet_id = "${var.subnet_private_1}"
  vpc_security_group_ids = ["${aws_security_group.zk_access.id}", "${aws_security_group.kafka_server.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "st1"
    volume_size = 500
    delete_on_termination = true
  }

  user_data = "${data.template_file.kafka_userdata_1.rendered}"
  key_name = "${var.key}"
}

output "Kafka IP 1:" {
  value = "${aws_instance.kafka_1.private_ip}"
}

resource "aws_instance" "kafka_2" {
  tags {
    Name = "Kafka-2"
  }
  ami = "ami-085d69987e6675f08"
  instance_type = "m4.large"
  subnet_id = "${var.subnet_private_2}"
  vpc_security_group_ids = ["${aws_security_group.zk_access.id}", "${aws_security_group.kafka_server.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "st1"
    volume_size = 500
    delete_on_termination = true
  }

  user_data = "${data.template_file.kafka_userdata_2.rendered}"
  key_name = "${var.key}"
}

output "Kafka IP 2:" {
  value = "${aws_instance.kafka_2.private_ip}"
}

resource "aws_instance" "kafka_3" {
  tags {
    Name = "Kafka-2"
  }
  ami = "ami-085d69987e6675f08"
  instance_type = "m4.large"
  subnet_id = "${var.subnet_private_3}"
  vpc_security_group_ids = ["${aws_security_group.zk_access.id}", "${aws_security_group.kafka_server.id}"]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "st1"
    volume_size = 500
    delete_on_termination = true
  }

  user_data = "${data.template_file.kafka_userdata_3.rendered}"
  key_name = "${var.key}"
}

output "Kafka IP 3:" {
  value = "${aws_instance.kafka_3.private_ip}"
}
