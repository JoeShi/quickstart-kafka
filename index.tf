variable "ami" {
  type = "map"
  default = {
    cn-northwest-1 = "ami-085d69987e6675f08"
    cn-north-1 = "ami-013ead89472fc7464"
  }
}

provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

resource "aws_security_group" "zk_kafka_cluster" {
  name_prefix = "ZK-Kafka-Cluster-"

  # 允许来自堡垒机的访问
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["${var.bastion_private_ip}/32"]
  }

  # 允许集群内机器互相访问
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    self = true
  }

  # 允许来自 zk_kafka_access 安全组的机器访问 Zookeeper
  ingress {
    from_port = 2181
    protocol = "tcp"
    to_port = 2181
    security_groups = ["${aws_security_group.zk_kafka_access.id}"]
  }

  # 允许来自 zk_kafka_access 安全组的机器访问 Kafka
  ingress {
    from_port = 9092
    protocol = "tcp"
    to_port = 9092
    security_groups = ["${aws_security_group.zk_kafka_access.id}"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# 为资源添加 Kafka-Access- 开头的安全组即可访问 Kafka 和 Zookeeper 集群
resource "aws_security_group" "zk_kafka_access" {
  name_prefix = "Kafka-Access-"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["${var.bastion_private_ip}/32"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

output "Kafka Access Security Group Id:" {
  value = "${aws_security_group.zk_kafka_access.id}"
}
