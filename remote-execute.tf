

resource "null_resource" "zk_1_remote" {
  triggers {
    cluster_instance_ids = "${aws_instance.zk_1.id}"
  }

  provisioner "remote-exec" {
    script = ""
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "$file(~/.ssh/aws.pem)"
    host = "${aws_instance.zk_1.private_ip}"
    bastion_host = "ec2-52-83-175-227.cn-northwest-1.compute.amazonaws.com.cn"
    bastion_private_key = "$file(~/.ssh/aws.pem)"
    bastion_user = "ec2-user"
  }
}
