

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "eks:UpdateKubeconfig",
            "Resource": "arn:aws:eks:us-east-1:496634356449:cluster/DEVOPS-BFA"
        }
    ]
}

// attach_iam_policy_commands.sh

#!/bin/bash

# Attach the IAM policy to the IAM user "ubuntu"
aws iam attach-user-policy --user-name ubuntu --policy-arn arn:aws:iam::496634356449:policy/UbuntuEKSPolicy

# Attach the IAM policy to an IAM role (replace YOUR_ROLE_NAME with the actual role name)
aws iam attach-role-policy --role-name YOUR_ROLE_NAME --policy-arn arn:aws:iam::496634356449:policy/UbuntuEKSPolicy

resource "null_resource" "bastion_setup" {

  # Specify the connection details to the bastion host
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/Downloads/")

    host = aws_instance.bastion_host.public_ip # Use the output variable to get the public IP
  }

  provisioner "local-exec" {
    command = "chmod +x setup_eks.sh ; ./setup_eks.sh"
  }

  # Trigger this null_resource when bastion host becomes available
  depends_on = [
    aws_instance.bastion_host
  ]
}

resource "null_resource" "test_eks_connection_with_bastion" {
  # Define the null_resource to test the connection to the worker group node

  # Specify the connection details to the worker group node
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/Downloads/")

    host = aws_eks_node_group.nodes_general.private_ip
  }

  # Trigger this null_resource when bastion_setup is complete
  depends_on = [
    null_resource.bastion_setup
  ]
}