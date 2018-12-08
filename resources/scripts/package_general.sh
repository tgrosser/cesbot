#!/bin/bash

GENERAL_PACKAGE_PATH=../configuration/general

# post dictionaries json to server
curl -X POST ${EDDI_URL}/regulardictionarystore/regulardictionaries -D ../work/header_dictionaries.txt --header 'Content-Type: application/json' --header 'Accept: application/json' -d @${GENERAL_PACKAGE_PATH}/dictionaries.json

# get dictionary id
DICTIONARIES_ID=$(cat ../work/header_dictionaries.txt | grep Location: | cut -c 11- | sed 's/.$//')
echo 'DICTIONARIES_ID:' ${DICTIONARIES_ID}

# post behavior sets json to server
curl -X POST ${EDDI_URL}/behaviorstore/behaviorsets -D ../work/header_behaviorsets.txt --header 'Content-Type: application/json' --header 'Accept: application/json' -d @${GENERAL_PACKAGE_PATH}/behaviorsets.json

# get behavior set id
BEHAVIORSETS_ID=$(cat ../work/header_behaviorsets.txt | grep Location: | cut -c 11- | sed 's/.$//')
echo 'BEHAVIORSETS_ID:' ${BEHAVIORSETS_ID}

curl -X POST ${EDDI_URL}/httpcallsstore/httpcalls -D ../work/header_httpcalls.txt --header 'Content-Type: application/json' --header 'Accept: application/json' -d @${GENERAL_PACKAGE_PATH}/httpcalls.json

# get http calls id
HTTPCALLS_ID=$(cat ../work/header_httpcalls.txt | grep Location: | cut -c 11- | sed 's/.$//')
echo 'HTTPCALLS_ID:' ${HTTPCALLS_ID}

# post output sets json to server
curl -X POST ${EDDI_URL}/outputstore/outputsets -D ../work/header_outputsets.txt --header 'Content-Type: application/json' --header 'Accept: application/json' -d @${GENERAL_PACKAGE_PATH}/outputsets.json

# get output sets id
OUTPUTSETS_ID=$(cat ../work/header_outputsets.txt | grep Location: | cut -c 11- | sed 's/.$//')
echo 'OUTPUTSETS_ID:' ${OUTPUTSETS_ID}

# process json template for package
jq -n --arg dict "${DICTIONARIES_ID}" --arg bhvs "${BEHAVIORSETS_ID}" --arg http "${HTTPCALLS_ID}" --arg otps "${OUTPUTSETS_ID}" -f ${GENERAL_PACKAGE_PATH}/pack_general.jq > ../work/pack_general.json

# post general package json to server
curl -X POST ${EDDI_URL}/packagestore/packages -D ../work/header_pack_general.txt --header 'Content-Type: application/json' --header 'Accept: application/json' -d @../work/pack_general.json

# get general packages id
GENERAL_PACKAGES_ID=$(cat ../work/header_pack_general.txt | grep Location: | cut -c 11- | sed 's/.$//')
echo 'GENERAL_PACKAGES_ID:' ${GENERAL_PACKAGES_ID}
