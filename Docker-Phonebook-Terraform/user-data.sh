#! /bin/bash
yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
curl -L "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir -p /home/ec2-user/bookstore-api
cd /home/ec2-user/bookstore-api
TOKEN=${user-data-git-token}
USER=${user-data-git-name}
FOLDER="https://$TOKEN@raw.githubusercontent.com/$USER/book-repo/main/" 
curl -s -o docker-compose.yml -L "$FOLDER"docker-compose.yml
docker-compose up -d