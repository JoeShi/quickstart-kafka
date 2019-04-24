data "aws_s3_bucket" "s3_connect" {
  bucket = "${var.s3_connect_bucket}"
}

resource "aws_iam_role" "s3_connect" {
  name_prefix = "S3-Connect-"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com.cn"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "s3_readwrite" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:PutAccountPublicAccessBlock",
                "s3:GetAccountPublicAccessBlock",
                "s3:ListAllMyBuckets",
                "s3:HeadBucket"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws-cn:s3:::${data.aws_s3_bucket.s3_connect.bucket}",
                "arn:aws-cn:s3:::${data.aws_s3_bucket.s3_connect.bucket}/*"
            ]
        }
    ]
}
EOF
  role = "${aws_iam_role.s3_connect.id}"
}

resource "aws_iam_instance_profile" "s3_connect_profile" {
  name_prefix = "S3-Connect-"
  role = "${aws_iam_role.s3_connect.name}"
}

output "S3-Connect Worker IAM Role" {
  value = "${aws_iam_role.s3_connect.name}"
}
