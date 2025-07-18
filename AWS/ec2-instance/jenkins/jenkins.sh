#!/bin/bash
yum update -y
yum install git docker -y
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
dnf install java-17-amazon-corretto -y
yum install jenkins -y
echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
service docker start
systemctl enable jenkins
usermod -aG docker jenkins
systemctl restart jenkins
