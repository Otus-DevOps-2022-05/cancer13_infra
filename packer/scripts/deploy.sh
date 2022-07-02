#!/bin/bash
cd /opt
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

cd /home/ubuntu

mv reddit.service /etc/systemd/system/reddit.service
systemctl daemon-reload
systemctl enable reddit.service
systemctl start reddit.service
systemctl status reddit.service


