#!/bin/bash

CES_FQDN=ecosystem.cloudogu.com
EDDI_URL=http://localhost:7070

function deleteconv
{
    echo -e "Deleting all conversations from coversation store...\n\n"
    # delete conversations
    curl -X GET ${EDDI_URL}/conversationstore/conversations > ../work/conversations.json
    for id in `jq '.[].resource' ../work/conversations.json | cut -c 62-  | sed 's/.$//'`; do
        echo $id
        curl -X DELETE ${EDDI_URL}/conversationstore/conversations/$id?deletePermanently=true
    done
}

echo -e "\n*** WARNING ***"
echo -e "This scripts deletes all conversation from the conversation store."
echo -e "This operation can't be undone!\n"

while true; do
    read -p "Are you sure to delete all conversations? [y|n]: " yn
    case $yn in
        [Yy]* ) deleteconv; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
