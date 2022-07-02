#!/bin/bash
wget https://mirror.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.2/multiverse/binary-amd64/mongodb-org_4.2.20_amd64.deb && \
wget https://mirror.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.2/multiverse/binary-amd64/mongodb-org-tools_4.2.20_amd64.deb && \
wget https://mirror.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.2/multiverse/binary-amd64/mongodb-org-shell_4.2.20_amd64.deb && \
wget https://mirror.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.2/multiverse/binary-amd64/mongodb-org-server_4.2.20_amd64.deb && \
wget https://mirror.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/dists/xenial/mongodb-org/4.2/multiverse/binary-amd64/mongodb-org-mongos_4.2.20_amd64.deb && \
apt-get install ./mongodb-org*.deb -y

systemctl enable mongod
systemctl start mongod
systemctl status mongod
