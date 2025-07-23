#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
if [[ ! $INSTALL_PROGRAMS == *"java"* ]]; then exit 0; fi;
echo "Instalando Java"

# https://www.linode.com/docs/guides/how-to-install-openjdk-ubuntu-22-04/
wget https://download.java.net/java/GA/jdk24.0.2/fdc5d0102fe0414db21410ad5834341f/12/GPL/openjdk-24.0.2_linux-x64_bin.tar.gz
tar xvf openjdk-*.tar.gz -C /opt
update-alternatives --install /usr/bin/java java /opt/jdk-*/bin/java 1000
update-alternatives --install /usr/bin/javac javac /opt/jdk-*/bin/javac 1000

echo "Configurar Path"

#Pegar Instalação do java e colocar para todos os usuários
echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))' >> /etc/profile.d/03-java.sh
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile.d/03-java.sh

# Limpar cache
rm openjdk-*.tar.gz