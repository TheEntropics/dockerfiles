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

USER_UID=$((5000+${USER_ID}))
SSH_PORT=$((12200+${USER_ID}))

echo "Going to setup the following user:"
echo "  --> username = ${USER_NAME}"
echo "  --> UID = ${USER_UID}"
echo "  --> ssh port = ${SSH_PORT}"
echo "  --> hostname = $(hostname)"
echo

echo "Setting up /etc/hosts"
echo "127.0.0.1 $(hostname)" >> /etc/hosts
echo "::1 $(hostname)" >> /etc/hosts

echo "Setting up sshd"
systemctl stop ssh
sed -i "s|#Port 22|Port ${SSH_PORT}|" /etc/ssh/sshd_config
systemctl start ssh

echo "Setting up sudo"
sed -i "s|%sudo.*|%sudo ALL=(ALL) NOPASSWD:ALL|" /etc/sudoers

echo "Creating user"
useradd \
    --home-dir /home/${USER_NAME} \
    --groups sudo \
    --create-home \
    --shell /usr/bin/zsh \
    --uid ${USER_UID} \
    ${USER_NAME}

echo "Setting up zsh"
wget -O /home/${USER_NAME}/.zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
chown ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/.zshrc

echo "Creating user ssh key"
su - ${USER_NAME} -c "ssh-keygen -N '' -f /home/${USER_NAME}/.ssh/id_rsa"

echo "Removing setup.sh"
rm /setup.sh
