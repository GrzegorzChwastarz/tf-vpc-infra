resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.tags["Project"]}-${var.tags["Environment"]}-ec2-profile"
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role" "ec2" {
  name               = "${var.tags["Project"]}-${var.tags["Environment"]}-ec2"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_policy_role_attachment" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.ssm.arn
}

resource "aws_iam_policy" "ssm" {
  name        = "${var.tags["Project"]}-${var.tags["Environment"]}-ssm"
  description = "SSM policy for session manager and parameter store"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocument",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ],
        "Resource": "*"
      },
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetEncryptionConfiguration"
          ],
          "Resource": "*"
        }
    ]
  }
EOF
}

resource "aws_iam_role_policy_attachment" "s3_policy_role_attachment" {
  role       = aws_iam_role.ec2.name
  policy_arn = aws_iam_policy.s3.arn
}

resource "aws_iam_policy" "s3" {
  name        = "${var.tags["Project"]}-${var.tags["Environment"]}-s3"
  description = "S3 policy for S3 bucket operations"

  policy = <<EOF
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action": "s3:ListAllMyBuckets",
         "Resource":"arn:aws:s3:::*"
      },
      {
         "Effect":"Allow",
         "Action":["s3:ListBucket","s3:GetBucketLocation"],
         "Resource":"arn:aws:s3:::*"
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:PutObject",
            "s3:PutObjectAcl",
            "s3:GetObject",
            "s3:GetObjectAcl",
            "s3:DeleteObject"
         ],
         "Resource":"arn:aws:s3:::*"
      }
   ]
}
EOF
}