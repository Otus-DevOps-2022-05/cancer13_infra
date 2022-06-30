#!/bin/bash
echo "deb [ trusted=yes ] https://ftp.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/ xenial/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get update --allow-unauthenticated
apt-get install -y mongodb git

systemctl enable mongodb
systemctl start mongodb
systemctl status mongodb
