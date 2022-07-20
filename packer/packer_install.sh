#!/bin/bash
# curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
# sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
# sudo apt-get update && sudo apt-get install packer

wget https://releases.hashicorp.com/packer/1.8.2/packer_1.8.2_linux_amd64.zip
unzip packer_1.8.2_linux_amd64.zip
mv packer /home/ivan/.local/bin/
rm packer_1.8.2_linux_amd64.zip
