# Sonarqube-installation-documentation
### How to export the cluster .kube/config file?

1- Login in AWS using the CLI first with your secret and access key

2- Run the below command to export the .kube/config file in your home directory

aws eks update-kubeconfig --name [cluster_name] --region [region]

aws eks update-kubeconfig --name [DEVOPS-BFA] --region [us-east-1]

Example: aws eks update-kubeconfig --name DEVOPS-BFA --region us-east-1


... AMI TYPE {eks.tf}

AL2_x86_64: This AMI type is for Amazon Linux 2 (AL2) on x86_64 (64-bit x86) architecture. Amazon Linux 2 is a Linux distribution provided by AWS optimized for use on their cloud platform. The x86_64 architecture is the most common architecture used in modern computers and servers.

AL2_x86_64_GPU: This AMI type is similar to AL2_x86_64 but is optimized for instances with GPU (Graphics Processing Unit) capabilities. It's typically used for tasks that require intensive parallel processing, such as machine learning, scientific computing, or 3D rendering.

AL2_ARM_64: This AMI type is for Amazon Linux 2 on ARM64 (64-bit ARM) architecture. ARM64 is an alternative processor architecture commonly found in mobile devices, embedded systems, and increasingly used in server environments for its energy efficiency and performance characteristics. This AMI type allows you to run instances on ARM-based EC2 instances.