#!/bin/bash
yum update -y
cd /opt
wget https://download.sonatype.com/nexus/3/nexus-3.70.3-01-java8-unix.tar.gz
tar -xvzf nexus-3.70.3-01-java8-unix.tar.gz
rm -rf nexus-3.70.3-01-java8-unix.tar.gz
mv nexus-3.70.3-01 nexus
useradd nexus
echo "nexus:Sathwik123" | chpasswd
echo "nexus ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R nexus:nexus nexus
chown -R nexus:nexus sonatype-work
cat <<EOF > nexus/bin/nexus.rc 
run_as_user="nexus"
EOF
cat <<EOF > /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target
  
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop 
User=nexus
Restart=on-abort
TimeoutSec=600
  
[Install]
WantedBy=multi-user.target
EOF
yum install java-1.8.0-amazon-corretto-devel -y
systemctl enable nexus
systemctl start nexus
