#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

docker network create $DOCKER_NETWORK || true

docker rm -f nginx-docker-dns || true

# https://github.com/erickweil/testedocker/tree/main/nginx-dns
docker run \
        -e DOMAIN_PREFIX='' \
        -e SERVER_NAME=$DOMINIO_ESCAPED \
        -e DEFAULT_PORT='80' \
        -d -p 80:80 --restart unless-stopped --network $DOCKER_NETWORK --name nginx-docker-dns erickweil/nginx-docker-dns:code