#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

export USERNAME=$1
export PASSWORD=$2

SQLFILE="./usuarios/$USERNAME/create_user.sql"
envsubst '${USERNAME} ${PASSWORD}' < "./templates/create_user.template.sql" > $SQLFILE

echo "Criando usuário no banco de dados"
mysql -h 127.0.0.1 < $SQLFILE
