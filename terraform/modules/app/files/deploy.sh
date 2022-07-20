#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install

sudo cp /tmp/reddit.service /etc/systemd/system/reddit.service
sudo systemctl enable reddit.service
sudo systemctl start reddit.service
echo COMPLETED
