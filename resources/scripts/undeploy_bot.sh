#!/bin/bash

EDDI_URL=http://localhost:7070

function deletebot
{
    echo -e "\nDeleting all dictionaries..."
    # delete dictionaries
    curl -X GET ${EDDI_URL}/regulardictionarystore/regulardictionaries/descriptors > ../work/dictionaries.json
    for id in `jq '.[].resource' ../work/dictionaries.json | cut -c 78-  | sed 's/.$//'`; do
        echo $id
        curl -X DELETE ${EDDI_URL}/regulardictionarystore/regulardictionaries/$id
    done

    echo -e "\nDeleting all behavior sets..."
    # delete behavior sets
    curl -X GET ${EDDI_URL}/behaviorstore/behaviorsets/descriptors > ../work/behaviorsets.json
    for id in `jq '.[].resource' ../work/behaviorsets.json | cut -c 53-  | sed 's/.$//'`; do
        echo $id
        curl -X DELETE ${EDDI_URL}/behaviorstore/behaviorsets/$id
    done

    echo -e "\nDeleting all http calls..."
    # delete http calls
    curl -X GET ${EDDI_URL}/httpcallsstore/httpcalls/descriptors > ../work/httpcalls.json
    for id in `jq '.[].resource' ../work/httpcalls.json | cut -c 52-  | sed 's/.$//'`; do
        echo $id
        curl -X DELETE ${EDDI_URL}/httpcallsstore/httpcalls/$id
    done

    echo -e "\nDeleting all output sets..."
    # delete output sets
    curl -X GET ${EDDI_URL}/outputstore/outputsets/descriptors > ../work/outputsets.json
    for id in `jq '.[].resource' ../work/outputsets.json | cut -c 47-  | sed 's/.$//'`; do
        echo $id
        curl -X DELETE ${EDDI_URL}/outputstore/outputsets/$id
    done

    echo -e "\nDeleting all packages..."
    # delete packages
    curl -X GET ${EDDI_URL}/packagestore/packages/descriptors > ../work/packages.json
    for id in `jq '.[].resource' ../work/packages.json | cut -c 47-  | sed 's/.$//'`; do
        echo $id
        curl -X DELETE ${EDDI_URL}/packagestore/packages/$id
    done

    echo -e "\nDeleting all bots..."
    # delete bots
    curl -X GET ${EDDI_URL}/botstore/bots/descriptors > ../work/bots.json
    for id in `jq '.[].resource' ../work/bots.json | cut -c 35-  | sed 's/.$//'`; do
        echo $id
        curl -X DELETE ${EDDI_URL}/botstore/bots/$id
    done
}

echo -e "\n*** WARNING ***"
echo -e "This scripts deletes all data from the bot store."
echo -e "This operation can't be undone!\n"

while true; do
    read -p "Are you sure to delete all bot data? [y|n]: " yn
    case $yn in
        [Yy]* ) deletebot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
