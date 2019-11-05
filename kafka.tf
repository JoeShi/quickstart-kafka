data "template_file" "kafka_userdata" {
  count = var.kafka_count
  template = file("${path.module}/scripts/kafka.tpl")
  vars = {
    broker_id = count.index + 1
    zooKeeperList = join(",", formatlist("%s:2181", aws_instance.zookeeper.*.private_ip))
  }
}

resource "aws_instance" "kafka" {
  count = var.kafka_count
  tags = {
    Name = "Kafka-${count.index + 1}"
    Index = count.index + 1
  }
  ami = lookup(var.ami, var.region)
  instance_type = var.kafka_instance_type
  subnet_id = element(var.subnets, count.index)
  vpc_security_group_ids = [aws_security_group.zk_kafka_cluster.id]
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/xvdb"
    volume_type = "st1"
    volume_size = var.kafka_volume_size
    delete_on_termination = true
  }

  user_data = element(data.template_file.kafka_userdata.*.rendered, count.index)
  key_name = var.key
}

output "Kafka_List" {
  value = join(",", formatlist("%s:9092", aws_instance.kafka.*.private_ip))
}
