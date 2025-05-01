#!/bin/bash

# Ensure the home directory has the correct permissions
chmod -R 755 /home/container

MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`

cd /home/container

corepack enable

yarn install --check-cache --production

echo "-- Server started, waiting for ${STARTUP_FILE}..."

${MODIFIED_STARTUP}
