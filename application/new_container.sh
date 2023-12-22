#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

source ./env.sh

export USERNAME=$1
export PASSWORD=$2
export CODEPORT=$3
export SSHPORT=$4

for script in on-new-container/*.sh
do
  printf "Executing script: %s\n" "$script"
  bash ./"$script" $USERNAME $PASSWORD $CODEPORT $SSHPORT
done
