#!/bin/bash

EDDI_URL=http://localhost:7070

rm ../work/* 2> /dev/null

# create packages
. ./package_general.sh
. ./package_redmine.sh

# process json template for package
jq -n --arg general "${GENERAL_PACKAGES_ID}" --arg redmine "${REDMINE_PACKAGES_ID}" -f ../configuration/bots.jq > ../work/bots.json

# post bots json to server
curl -X POST ${EDDI_URL}/botstore/bots -D ../work/header_bots.txt --header 'Content-Type: application/json' --header 'Accept: application/json' -d @../work/bots.json

# get bots id
BOTS_ID=$(cat ../work/header_bots.txt | grep Location: | cut -c 44- | sed 's/.$//')
echo 'BOTS_ID:' ${BOTS_ID}

# deploy bots
curl -X POST ${EDDI_URL}/administration/restricted/deploy/${BOTS_ID}&autoDeploy=true

echo -e "\nStart chatting at "${EDDI_URL}"/chat/restricted/"${BOTS_ID}
