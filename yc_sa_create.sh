#!/bin/bash
SVC_ACCT=sa-parcker
FOLDER_ID=$(yc config list | yq '.folder-id')

yc iam service-account create --name $SVC_ACCT --folder-id $FOLDER_ID
sleep 5
ACCT_ID=$(yc iam service-account get $SVC_ACCT | \
grep ^id | \
awk '{print $2}')

yc resource-manager folder add-access-binding --id $FOLDER_ID \
--role editor \
--service-account-id $ACCT_ID
sleep 5
