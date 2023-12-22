#!/bin/bash
set -e # Se falhar 1 comando falha tudo.

cd ./mysql
docker compose up -d