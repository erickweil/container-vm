#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
if [[ ! $INSTALL_PROGRAMS == *"php-nginx"* ]]; then exit 0; fi;
echo "Configurando nginx para usuário $USERNAME"

# Configurar nginx para o novo usuário
# Se não tiver instalação do nginx, não precisa fazer nada
if [ ! -d "/etc/nginx" ]; then
	exit 0
fi

# Se tem Workspace, usa ele, senão usa o padrão do nginx
if [ ! -z "$WORKSPACE" ]; then
	export NGINXROOT=${DEFAULT_NGINXROOT:-"$WORKSPACE/public_html"}
else
	export NGINXROOT=${DEFAULT_NGINXROOT:-"/var/www/html"}
fi

envsubst '${NGINXROOT}' < "php-nginx-default.conf" > "/etc/nginx/sites-available/default"

# cria um index.html padrão se for a primeira vez
if [ ! -d "$NGINXROOT" ]; then
	mkdir -p $NGINXROOT
	envsubst '${NGINXROOT} ${USERNAME}' < "index.html" > "$NGINXROOT/index.html"
fi

# Para aplicar a configuração nova
systemctl reload nginx || true