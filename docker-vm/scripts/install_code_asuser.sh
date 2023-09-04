#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
# RODANDO COMO USUÁRIO COMUM, NÃO TEM NENHUMA ENV
cd $HOME
echo "Instalando code-server [as user]"

# TEM QUE RODAR NO USUÁRIO QUE VAI USAR O CODE-SERVER
# Como instalar extensões -> https://github.com/coder/code-server/issues/3173

# NÃO FUNCIONA INSTALAR LANGUAGE PELO TERMINAL --> https://github.com/coder/code-server/issues/3372
# Possível solução? https://github.com/coder/code-server/issues/6168
#code-server --install-extension ms-ceintl.vscode-language-pack-pt-br

# Isso será substituído pelo envsubst, porque não pega a env
EXTENSIONS="${INSTALL_VSCODE_EXTENSIONS}"
for extension in $EXTENSIONS; do
    echo "Instalando extensão \"$extension\""
    code-server --install-extension $extension
done
