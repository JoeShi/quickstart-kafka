# 简介

自动化部署 **Zookeeper** 和 **Kafka**

Zookeeper: 3.4.6
Kafka: 0.10.1

## 部署前提

1. 本机已经安装 [Terraform](https://www.terraform.io/downloads.html)


## 安装步骤

1. 修改 `variables.tf` 文件，如果选择是 private subnet, 请确保已经绑定 **NAT** 网关

2. 执行 **Terraform** 脚本
```bash
terraform init
terraform apply
```
> 执行完脚本，需要等待EC2 安装 JAVA, Zookeeper等软件，需要等待几分钟。请确定Java等软件已经
> 安装完成再执行以下操作

3. 登录一台 **Zookeeper** 实例，修改 `/opt/zookeeper-3.4.6/conf/zoo.cfg`. 将文件
中的IP地址改成 Zookeeper 的 **Private IP**。 或者直接 `sudo cp /tmp/zoo.cfg /opt/zookeeper-3.4.6/conf/`.
已经通过 terraform 自动生成配置文件.

```text
server.1=172.31.100.52:2888:3888
server.2=172.31.101.242:2888:3888
server.3=172.31.102.42:2888:3888
```

4. 启动 Zookeeper。`sudo systemctl start zoo`，将 **Zookeeper** 设置成随机启动 `sudo systemctl enable zoo`
5. 为其他两外 **Zookeeper** 实例执行相同的操作
6. 登录一台 **Kafka** 实例，启动进程`sudo systemctl start kafka` ，并将 **Kafka** 设置成随机启动 `sudo systemctl enable kafka`
7. 为其他两台 **Kafka** 执行相同操作


## 安装 S3-Connect

本文使用 S3-Connect 的 docker image 来实现，数据从 Kafka 导入 S3.



## 测试命令

```shell
./kafka-topics.sh --zookeeper 172.31.100.90:2181,172.31.101.19:2181,172.31.101.183:2181 --create --topic s3connect --partitions 3 --replication-factor 2
./kafka-topics.sh --zookeeper 172.31.100.90:2181,172.31.101.19:2181,172.31.101.183:2181 --describe --topic s3connect
./kafka-console-producer.sh --broker-list 172.31.100.158:9092,172.31.101.37:9092,172.31.101.150:9092 --topic s3connect
./kafka-console-consumer.sh --bootstrap-server 172.31.100.158:9092,172.31.101.37:9092,172.31.101.150:9092 --topic s3connect --from-beginning
```
