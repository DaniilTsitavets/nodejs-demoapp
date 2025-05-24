#!/bin/bash
apt update
apt install -y docker.io jq unzip curl

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp
/tmp/aws/install

systemctl start docker
systemctl enable docker

curl https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o /home/ubuntu/global-bundle.pem
chmod 644 /home/ubuntu/global-bundle.pem
chown ubuntu:ubuntu /home/ubuntu/global-bundle.pem

SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id task3-docdb --query SecretString --output text --region eu-north-1)

DB_USERNAME=$(echo $SECRET_JSON | jq -r '.username')
DB_PASSWORD=$(echo $SECRET_JSON | jq -r '.password')
DB_ENDPOINT=$(echo $SECRET_JSON | jq -r '.endpoint')

cat <<EOF > /etc/systemd/system/demoapp.service
[Unit]
Description=NodeJS app
After=docker.service
Requires=docker.service

[Service]
Restart=Always
Environment="TODO_MONGO_CONNSTR=mongodb://${DB_USERNAME}:${DB_PASSWORD}@${DB_ENDPOINT}:27017/?tls=true&tlsCAFile=/certs/global-bundle.pem&retryWrites=false"
ExecStart=/usr/bin/docker run -p 3000:3000 -e TODO_MONGO_CONNSTR="mongodb://${DB_USERNAME}:${DB_PASSWORD}@${DB_ENDPOINT}:27017/?tls=true&tlsCAFile=/certs/global-bundle.pem&retryWrites=false" -v /home/ubuntu/global-bundle.pem:/certs/global-bundle.pem:ro ghcr.io/benc-uk/nodejs-demoapp:latest

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl start demoapp
systemctl enable demoapp