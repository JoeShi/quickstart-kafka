# public key name of Zookeer and Kafka Instances, do NOT include .pem
variable "key" {
  default = "shiheng"
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
  default = ["subnet-40dc7629", "subnet-c120ecba", "subnet-e1fad2ab"]
}

# private IP of bastion machine.
variable "bastion_private_ip" {
  default = "172.31.25.2"
}

variable "s3_connect_bucket" {
  default = "shiheng-poc"
}

variable "bastion_public_host" {
  default = "ec2-52-82-109-180.cn-northwest-1.compute.amazonaws.com.cn"
}

variable "bastion_username" {
  default = "ec2-user"
}

# private key path for bastion machine
variable "bastion_private_key" {
  default = "~/.ssh/shiheng.pem"
}

# private pem key to access instances, used for uploading configuration file of zookeeper
variable "private_key" {
  default = "~/.ssh/shiheng.pem"
}

variable "zk_instance_type" {
  default = "t2.large"
}

variable "zk_volume_size" {
  default = 50
}

variable "zk_count" {
  default = 3
}

variable "kafka_instance_type" {
  default = "t2.large"
}

// EBS st1 requires volume size >= 500G
variable "kafka_volume_size" {
  default = 500
}

variable "kafka_count" {
  default = 3
}

