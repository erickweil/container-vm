#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
# RODANDO COMO USUÁRIO COMUM, NÃO TEM NENHUMA ENV
cd $HOME
echo "Instalando code-server [as user]"

# TEM QUE RODAR NO USUÁRIO QUE VAI USAR O CODE-SERVER
# Como instalar extensões -> https://github.com/coder/code-server/issues/3173
# Depois, receber a lista de extensões pelos argumentos

# NÃO FUNCIONA INSTALAR LANGUAGE PELO TERMINAL --> https://github.com/coder/code-server/issues/3372
# Possível solução? https://github.com/coder/code-server/issues/6168
#code-server --install-extension ms-ceintl.vscode-language-pack-pt-br

# ESLint - dbaeumer.vscode-eslint
#code-server --install-extension dbaeumer.vscode-eslint

# Kubernetes + Yaml - ms-kubernetes-tools.vscode-kubernetes-tools
code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools

# Java Language Pack - vscjava.vscode-java-pack
#code-server --install-extension vscjava.vscode-java-pack