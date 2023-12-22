#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

source ./env.sh

for script in on-install/*.sh
do
  printf "Executing script: %s\n" "$script"
  ./"$script"
done
