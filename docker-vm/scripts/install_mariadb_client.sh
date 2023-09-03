#!/bin/bash
if [[ ! $INSTALL_PROGRAMS == *"mariadb-client"* ]]; then exit 0; fi;
echo "Instalando mariadb client"

# https://stackoverflow.com/questions/5287220/is-there-a-way-to-only-install-the-mysql-client-linux
apt-get install mariadb-client -y