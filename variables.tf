# public key name of Zookeer and Kafka Instances, do NOT include .pem
variable "key" {
  default = "aws"
}

# ONLY support cn-northwest-1, cn-north-1 regions
variable "region" {
  default = "cn-northwest-1"
}

# Change to your local aws profile.
variable "profile" {
  default = "zhy" # default
}

# prefer private subnets for security reason
variable "subnets" {
  type = "list"
  default = ["subnet-01960b79211596db0", "subnet-0c087c505790a067d", "subnet-0cdccbae920c4b603"]
}

# private IP of bastion machine.
variable "bastion_private_ip" {
  default = "172.31.38.158"
}

variable "s3_connect_bucket" {
  default = "s3-connect"
}

variable "bastion_public_host" {
  default = "ec2-52-83-175-227.cn-northwest-1.compute.amazonaws.com.cn"
}

variable "bastion_username" {
  default = "ec2-user"
}

# private key path for bastion machine
variable "bastion_private_key" {
  default = "~/.ssh/aws.pem"
}

# private pem key to access instances, used for uploading configuration file of zookeeper
variable "private_key" {
  default = "~/.ssh/aws.pem"
}

variable "zk_instance_type" {
  default = "m4.large"
}

variable "zk_volume_size" {
  default = 100
}

variable "zk_count" {
  default = 3
}

variable "kafka_instance_type" {
  default = "m4.large"
}

// EBS st1 requires volume size >= 500G
variable "kafka_volume_size" {
  default = 500
}

variable "kafka_count" {
  default = 3
}

