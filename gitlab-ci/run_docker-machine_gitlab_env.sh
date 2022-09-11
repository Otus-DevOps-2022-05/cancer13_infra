#!/bin/bash
yc compute instance create \
  --name docker-gitlab \
  --hostname docker-host \
  --memory=8 \
  --cores=4 \
  --core-fraction=5 \
  --preemptible \
  --zone ru-central1-a \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=50 \
  --ssh-key ~/.ssh/id_rsa_appuser.pub && \
EXT_IP=$(yc compute instance get --name docker-gitlab --format json | jq -r '.network_interfaces[].primary_v4_address.one_to_one_nat.address') && \
echo 'YC VM HOST CREATE' && \
docker-machine create \
  --driver generic \
  --generic-ip-address=$EXT_IP \
  --generic-ssh-user yc-user \
  --generic-ssh-key ~/.ssh/id_rsa_appuser \
  docker-gitlab && \
echo 'DOCKER-MACHIN HOST CREATE' && \
ssh -i ~/.ssh/id_rsa_appuser yc-user@$EXT_IP 'sudo mkdir -p /srv/gitlab/config /srv/gitlab/data /srv/gitlab/logs' && \
echo $EXT_IP && \
eval $(docker-machine env docker-gitlab) && \
docker-compose up -d && \
sleep 120 && \
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password && \
docker run -d --name gitlab-runner --restart always -v /srv/gitlabrunner/config:/etc/gitlab-runner -v /var/run/docker.sock:/var/run/docker.sock gitlab/gitlab-runner:latest ;

