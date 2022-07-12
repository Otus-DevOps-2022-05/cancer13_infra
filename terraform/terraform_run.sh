#!/bin/bash
terraform plan
terraform apply --auto-approve

# ssh -i ~/.ssh/appuser ubuntu@$(terraform show -json | \
# jq '.values.root_module.resources[0].values.network_interface[0].nat_ip_address' | \
# tr -d '"')

ssh -i ~/.ssh/appuser ubuntu@$(terraform output external_ip_address_app | tr -d '"')
