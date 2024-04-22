# IAM role for EBS CSI Driver
resource "aws_iam_role" "ebs_csi_driver_role" {
  name               = "Devops-Bfa-ebs_csi_driver_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# IAM policy for EBS CSI Driver
resource "aws_iam_policy" "ebs_csi_driver_policy" {
  name   = "Devops-Bfa-ebs-csi-driver-policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeVolumes",
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:DescribeSnapshots",
        "ec2:CreateSnapshot",
        "ec2:DeleteSnapshot",
        "ec2:CreateTags"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" {
  role       = aws_iam_role.ebs_csi_driver_role.name
  policy_arn = aws_iam_policy.ebs_csi_driver_policy.arn
}
