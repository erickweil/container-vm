#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

docker network create net-vm || true

docker rm -f nginx-docker-dns || true

# https://github.com/erickweil/testedocker/tree/main/nginx-dns
docker run \
        -e DOMAIN_PREFIX='' \
        -e SERVER_NAME='\\.code\\.fslab\\.dev' \
        -e DEFAULT_PORT='80' \
        -d -p 80:80 --restart unless-stopped --network net-vm --name nginx-docker-dns erickweil/nginx-docker-dns:code