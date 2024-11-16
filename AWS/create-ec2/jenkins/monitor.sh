#!/bin/bash
yum update -y
yum install docker -y
systemctl enable docker
systemctl start docker
docker network create demo
docker run -d --name cont1 --network demo -p 9090:9090 prom/prometheus:latest
docker run -d --name cont2 --network demo -p 3000:3000 grafana/grafana:latest
cat <<EOF > prometheus.yml
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets:
          - localhost:9090
  - job_name: jenkins
    metrics_path: /prometheus/
    static_configs:
      - targets:
          - jk_ip:8080
EOF
docker cp prometheus.yml cont1:/etc/prometheus/prometheus.yml
docker restart cont1
