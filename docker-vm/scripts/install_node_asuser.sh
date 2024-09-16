#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
# RODANDO COMO USUÁRIO COMUM, NÃO TEM NENHUMA ENV
cd $HOME
echo "Instalando node [as user]"

# Instalar node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Para funcionar o comando nvm agora
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install --lts
