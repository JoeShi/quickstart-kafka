variable "ami" {
  type = "map"
  default = {
    cn-northwest-1 = "ami-085d69987e6675f08"
  }
}

provider "aws" {
  region = "cn-northwest-1"
  profile = "zhy"
}

resource "aws_security_group" "zk_access" {
  name_prefix = "ZookeeperAccess-"
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "zk_server" {
  name_prefix = "ZookeeperServer-"
  ingress {
    from_port = 2181
    protocol = "tcp"
    to_port = 2181
    security_groups = ["${aws_security_group.zk_access.id}"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = ["${var.bastion_sg_id}"]
  }

  ingress {
    from_port = 2888
    protocol = "tcp"
    to_port = 2888
    self = true
  }

  ingress {
    from_port = 3888
    protocol = "tcp"
    to_port = 3888
    self = true
  }

  ingress {
    from_port = 2181
    protocol = "tcp"
    to_port = 2181
    self = true
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "kafka_server" {
  name_prefix = "KafkaServer-"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = ["${var.bastion_sg_id}"]
  }

  ingress {
    from_port = 9092
    protocol = "tcp"
    to_port = 9092
    security_groups = ["${aws_security_group.kafka_access.id}"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "kafka_access" {
  name_prefix = "KafkaAccess-"
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    security_groups = ["${var.bastion_sg_id}"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
