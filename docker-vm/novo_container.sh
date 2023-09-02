#!/bin/bash
export USERNAME=$1
export PASSWORD=$2
export CODEPORT=$3
export SSHPORT=$4

echo "Criando arquivos de configuração"
mkdir -p "./usuarios/$USERNAME"

ENVFILE="./usuarios/$USERNAME/.env"
envsubst < ".env.template" > $ENVFILE

COMPOSEFILE="./usuarios/$USERNAME/docker-compose.yml"
cp "./docker-compose.yml" $COMPOSEFILE

#SQLFILE="./usuarios/$USERNAME/create_user.sql"
#envsubst '${USERNAME} ${PASSWORD}' < "create_user.template.sql" > $SQLFILE

#echo "Criando usuário no banco de dados"
#mysql -h 127.0.0.1 < $SQLFILE

echo "Parando o container"
docker compose -f $COMPOSEFILE --env-file $ENVFILE down

echo "Iniciando o container"
docker compose -f $COMPOSEFILE --env-file $ENVFILE up -d
#sleep 5