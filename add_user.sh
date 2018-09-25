#!/usr/bin/env bash

set -e

USER_NAME=$1
USER_ID=$2

usage() {
    echo "Usage: $0 username id"
    echo "id should be a number from 1"
    echo " --> UID = 5000+id"
    echo " --> ssh port = 12200+id"
    exit 1
}

if [ -z "${USER_NAME}" ]; then
    usage
fi
if [ -z "${USER_ID}" ]; then
    usage
fi

echo "Creating the container"
docker run \
    -d --rm -it \
    -v /volumes/homes/${USER_NAME}:/home \
    -v /sys/fs/cgroup:/sys/fs/cgroup \
    --tmpfs /run --tmpfs /run/lock \
    --network=host \
    --hostname=${USER_NAME}-serben \
    --cap-add=SYS_ADMIN \
    -e container=docker \
    --label "user=${USER_NAME}" \
    --name ${USER_NAME}-user \
    --restart unless-stopped \
    ubuntu-users

echo "Setting it up"
docker exec -it ${USER_NAME}-user /setup.sh ${USER_NAME} ${USER_ID}
