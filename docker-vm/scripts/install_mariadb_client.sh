#!/bin/bash
# https://stackoverflow.com/questions/5287220/is-there-a-way-to-only-install-the-mysql-client-linux
if [[ ! $INSTALL_PROGRAMS == *"mariadb-client"* ]]; then exit 0; fi;

apt-get install mariadb-client -y