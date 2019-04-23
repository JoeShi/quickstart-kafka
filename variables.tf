# public key name of Instance, do NOT include .pem
variable "key" {
  default = "aws"
}

variable "region" {
  default = "cn-northwest-1"
}

variable "subnet_private_1" {
  default = "subnet-01960b79211596db0"
}

variable "subnet_private_2" {
  default = "subnet-0c087c505790a067d"
}

variable "subnet_private_3" {
  default = "subnet-0cdccbae920c4b603"
}

variable "bastion_sg_id" {
  default = "sg-03baaf2b2ed632f20"
}

variable "s3_connect_bucket" {
  default = "s3-connect"
}

variable "bastion_host" {
  default = "ec2-52-83-175-227.cn-northwest-1.compute.amazonaws.com.cn"
}

variable "bastion_username" {
  default = "ec2-user"
}

variable "bastion_private_key" {
  default = "~/.ssh/aws.pem"
}

variable "private_key" {
  default = "~/.ssh/aws.pem"
}

variable "zk_instance_type" {
  type = "string"
  default = "m4.large"
}

variable "zk_volume_size" {
  default = 100
}

variable "zk_count" {
  default = 3
}

variable "kafka_instance_type" {
  type = "string"
  default = "m4.large"
}

// EBS st1 requires volume size >= 500G
variable "kafka_volume_size" {
  default = 500
}


variable "kafka_count" {
  default = 3
}
