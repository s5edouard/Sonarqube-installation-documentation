#!/bin/bash

# Set noninteractive frontend for debconf
export DEBIAN_FRONTEND=noninteractive

# Update package lists
sudo apt-get update
sudo apt-get upgrade -y

# Install missing dependencies
sudo apt-get install -f -y

# Install unzip and sudo
sudo apt-get install -y unzip sudo

# Add universe repository
sudo add-apt-repository universe -y

# Re-update package lists
sudo apt-get update

# Install essential packages
sudo apt-get install -y apt-utils build-essential wget python3-venv python3-pip vim default-jre default-jdk htop mysql-server maven openssh-server watch tree postgresql-client-common postgresql-client-14

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Installing Docker
sudo apt-get remove docker docker-engine docker.io containerd runc -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
sudo chown root:docker /var/run/docker.sock
sudo chmod 666 /var/run/docker.sock

# Installing Docker-Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Installing Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh

# Installing trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/trivy.gpg
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install -y trivy

# Installing kubectl
sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl 
sudo chmod +x ./kubectl 
sudo mv kubectl /usr/local/bin/

# Installing kubectx and kubens
sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx 
sudo wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens 
sudo chmod +x kubectx kubens 
sudo mv kubectx kubens /usr/local/bin/

# Installing Packer
sudo wget https://releases.hashicorp.com/packer/1.7.4/packer_1.7.4_linux_amd64.zip -P /tmp
sudo unzip /tmp/packer_1.7.4_linux_amd64.zip -d /usr/local/bin
sudo chmod +x /usr/local/bin/packer

# Installing ArgoCD agent
wget https://github.com/argoproj/argo-cd/releases/download/v2.8.5/argocd-linux-amd64
chmod +x argocd-linux-amd64
sudo mv argocd-linux-amd64 /usr/local/bin/argocd

# Upgrading pip
pip3 install --upgrade pip

# Add .local/bin to PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# Installing SonarScanner CLI
sonar_scanner_version="5.0.1.3006"                 
wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${sonar_scanner_version}-linux.zip
unzip sonar-scanner-cli-${sonar_scanner_version}-linux.zip
sudo mv sonar-scanner-${sonar_scanner_version}-linux /opt/sonar-scanner
sudo ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/

# Installing Terraform
TERRAFORM_VERSION="1.0.0"
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Installing Terragrunt
TERRAGRUNT_VERSION="v0.38.0"
wget https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 
sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt
sudo chmod +x /usr/local/bin/terragrunt

# Installing grype
GRYPE_VERSION="0.66.0"
wget https://github.com/anchore/grype/releases/download/v${GRYPE_VERSION}/grype_${GRYPE_VERSION}_linux_amd64.tar.gz
tar -xzf grype_${GRYPE_VERSION}_linux_amd64.tar.gz
sudo mv grype /usr/local/bin/
rm grype_${GRYPE_VERSION}_linux_amd64.tar.gz

# Installing Gradle
GRADLE_VERSION="4.10"
sudo apt install openjdk-11-jdk -y
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
unzip gradle-${GRADLE_VERSION}-bin.zip
sudo mv gradle-${GRADLE_VERSION} /opt/
sudo ln -s /opt/gradle-${GRADLE_VERSION}/bin/gradle /usr/local/bin/

# Installing awscli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws

# Installing Ansible
python3 -m pip install --user ansible 
 
# Add .local/bin to PATH{ on Command Line Interface}
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

## Installing Jenkins##
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins

# Start and enable Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Display the initial Jenkins administrator password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword