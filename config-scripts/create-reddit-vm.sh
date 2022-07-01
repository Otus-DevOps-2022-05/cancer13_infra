#!/usr/bin/env bash
yc compute instance create \
  --name reddit-app-immutable \
  --hostname reddit-app-immutable \
  --memory=4 \
  --create-boot-disk image-folder-id=b1ge1vhv03cd1ss5bcsh,image-family=reddit-full,size=10GB\
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub

ssh -i ~/.ssh/appuser yc-user@$(yc compute instance get reddit-app-immutable --format json | jq -r '.network_interfaces[].primary_v4_address.one_to_one_nat.address')
