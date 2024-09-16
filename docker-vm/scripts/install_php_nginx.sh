#!/bin/bash
set -e # Se falhar 1 comando falha tudo.
if [[ ! $INSTALL_PROGRAMS == *"php-nginx"* ]]; then exit 0; fi;
echo "Instalando php-nginx"

# https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04
# Será configurado para escutar na porta 80 e hospedar os sites no diretóio /var/www/html por padrão
echo "Instalar Nginx e PHP" \
	&& apt-get install --no-install-recommends -y php8.3 \
	&& apt-get install -y \
	nginx \
	php8.3-cli \
	php8.3-common \
	php8.3-mysql \
	php8.3-zip \
	php8.3-gd \
	php8.3-mbstring \
	php8.3-curl \
	php8.3-xml \
	php8.3-bcmath \
	php8.3-fpm;

# Impedir que tenha o mesmo número de processos que o número de núcleos
# https://stackoverflow.com/questions/11245144/replace-whole-line-containing-a-string-using-sed
sed -i -e "s/^worker_processes.*$/worker_processes 1;/" /etc/nginx/nginx.conf

# Iniciar apenas 1 thread do php-fpm
# https://gist.github.com/fromthestone/f4fa580f6637c0855fd3a9819083f70d
sed -i -e "s/^pm\.start_servers.*$/pm.start_servers = 1/" /etc/php/*/fpm/pool.d/www.conf

export NGINXROOT="/var/www/html"
envsubst '${NGINXROOT}' < "php-nginx-default.conf" > "/etc/nginx/sites-available/default"

# Verificar configuração do nginx
nginx -t