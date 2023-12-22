#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

export USERNAME=$1
export PASSWORD=$2
export CODEPORT=$3
export SSHPORT=$4

export USER_CONTAINER_IMAGE="registry.fslab.dev/erickweil/container-vm:complete"
export DOCKER_NETWORK="net-vm"

echo "Criando arquivos de configuração"
mkdir -p "./usuarios/$USERNAME"

ENVFILE="./usuarios/$USERNAME/.env"
envsubst < "./templates/.env.template" > $ENVFILE

COMPOSEFILE="./usuarios/$USERNAME/docker-compose.yml"
cp "./templates/docker-compose.yml" $COMPOSEFILE

echo "Parando o container"
docker compose -f $COMPOSEFILE --env-file $ENVFILE down

echo "Iniciando o container"
docker compose -f $COMPOSEFILE --env-file $ENVFILE up -d

sleep 1

docker logs $USERNAME