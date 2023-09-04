#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
# RODANDO COMO USUÁRIO COMUM, NÃO TEM NENHUMA ENV
cd $HOME
echo "Configurando git"

# Script de instalação / Configuração que executa como usuário comum
# Apenas a primeira vez que o container é criado e se o volume estiver vazio
# Configuração do usuário, configuração git e criação de chave ssh padrão
# Tem que rodar como usuário comum

# Configurar o git e chave ssh
if [ ! -d "~/.ssh" ]; then
    # NÃO CONFIGURAR O USUARIO E EMAIL DO GIT, POIS IRÁ ESTRAGAR
    # O HISTÓRICO DE COMMIT DO REPOSITÓRIO
    #git config --global user.name $USER &&
    #git config --global user.email $USER@local &&
    git config --global core.editor nano &&
    mkdir -p ~/.ssh
    ssh-keygen -t ed25519 -q -f ~/.ssh/id_ed25519 -N ""
fi