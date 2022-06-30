#!/usr/bin/env bash
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub

sleep 60 # wait vm is up

ssh -i ~/.ssh/appuser appuser@$(yc compute instance get reddit-app --format json | jq -r '.network_interfaces[].primary_v4_address.one_to_one_nat.address') "bash -s" < ./install_ruby.sh ./install_mongodb.sh ./deploy.sh