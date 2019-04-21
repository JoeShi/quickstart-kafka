# 简介

自动化部署 **Zookeeper** 和 **Kafka**

Zookeeper: 3.4.6
Kafka: 0.10.1

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
中的IP地址改成 Zookeeper 的 **Private IP**.

```text
server.1=172.31.100.52:2888:3888
server.2=172.31.101.242:2888:3888
server.3=172.31.102.42:2888:3888
```

4. 启动 Zookeeper。`sudo systemctl start zoo`，将 **Zookeeper** 设置成随机启动 `sudo systemctl enable zoo`
5. 为其他两外 **Zookeeper** 实例执行相同的操作
6. 登录一台 **Kafka** 实例，启动进程`sudo systemctl start kafka` ，并将 **Kafka** 设置成随机启动 `sudo systemctl enable kafka`
7. 为其他两台 **Kafka** 执行相同操作

