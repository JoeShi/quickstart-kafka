#!/bin/bash

yum update -y
yum install java-1.8.0-amazon-corretto
mkfs -t xfs /dev/xvdb
mkdir /data
mount /dev/xvdb /data
echo "/dev/xvdb /data  xfs  defaults,nofail  0  2" >> /etc/fstab  # automatically mount ebs

cd /opt
curl "https://s3.cn-northwest-1.amazonaws.com.cn/aws-quickstart/mirror/apache/zookeeper/zookeeper-3.4.6.tar.gz" -o /tmp/zookeeper.tgz
mkdir /opt/zookeeper
cd /opt/zookeeper
tar -xzf /tmp/zookeeper.tgz --strip 1

mkdir -p /data/zookeeper
touch /data/zookeeper/myid
echo "${index}" >> /data/zookeeper/myid

cat > /opt/zookeeper/conf/zoo.cfg <<EOF
tickTime=2000
initLimit=5
syncLimit=2
dataDir=/data/zookeeper
clientPort=2181
server.1=172.31.100.52:2888:3888
server.2=172.31.101.242:2888:3888
server.3=172.31.102.42:2888:3888
EOF

cat > /etc/systemd/system/zoo.service <<EOF
[Unit]
Description=Zookeeper Daemon
Wants=syslog.target

[Service]
Type=forking
WorkingDirectory=/opt/zookeeper/bin
User=root
ExecStart=/opt/zookeeper/bin/zkServer.sh start
ExecStop=/opt/zookeeper/bin/zkServer.sh stop
ExecReload=/opt/zookeeper/bin/zkServer.sh restart
TimeoutSec=30
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
