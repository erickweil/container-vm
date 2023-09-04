#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
if [[ ! $INSTALL_PROGRAMS == *"node"* ]]; then exit 0; fi;
echo "Instalando node"

# https://stackoverflow.com/questions/1988249/how-do-i-use-su-to-execute-the-rest-of-the-bash-script-as-that-user
sudo -H -i -u $INSTALL_USER bash < ./install_node_asuser.sh

# Mover nvm para pasta fora do $HOME
mv $INSTALL_HOME/.nvm /opt/nvm

# Não precisa mudar as permissões mais
# chmod -R 777 /opt/nvm

#Colocar o ENV do node para todos os usuários
echo 'export NVM_DIR="/opt/nvm"' >> /etc/profile.d/02-nvm.sh
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /etc/profile.d/02-nvm.sh # This loads nvm
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> /etc/profile.d/02-nvm.sh # This loads nvm bash_completion