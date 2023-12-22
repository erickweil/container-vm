#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

cd ./mysql

envsubst < .env.template > .env

docker compose up -d