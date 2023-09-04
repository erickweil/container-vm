#
# Ubuntu Bionic + Systemd + sshd + Docker
#
# Usage:
#
# $ docker run --runtime=sysbox-runc -it --rm -P --name=syscont nestybox/ubuntu-bionic-systemd-docker
#
# This will run systemd and prompt for a user login; the default
# user/password in this image is "admin/admin". Once you log in you
# can run Docker inside as usual. You can also ssh into the image:
#
# $ ssh admin@<host-ip> -p <host-port>
#
# where <host-port> is chosen by Docker and mapped into the system container's sshd port.
#
FROM ghcr.io/nestybox/ubuntu-jammy-systemd:latest

# Code-Server
EXPOSE 8080

WORKDIR /root

# Controle de que programas serão instalados ao fazer o build
# https://stackoverflow.com/questions/229551/how-to-check-if-a-string-contains-a-substring-in-bash
# if [[ ! $INSTALL_PROGRAMS == *"code"* ]]; then echo "Não"; else echo "Sim"; fi;

#:code
ARG INSTALL_PROGRAMS="locale code" 

ENV INSTALL_PROGRAMS=$INSTALL_PROGRAMS

# Para escolher o Timezone que o container irá usar
ENV TZ=America/New_York
# Para escolher o Locale que será instalado
ENV LANG=pt_BR.UTF-8

ENV INSTALL_USER=admin
ENV INSTALL_HOME=/home/admin

# Onde as extensões do code-server serão instaladas
ENV VSCODE_EXTENSIONS_PATH=/opt/vscode-extensions

# Instalar primeiro o code para ter cache nos layers pelo menos do code
COPY scripts/install.sh \
	scripts/install_locale.sh \
	scripts/install_code.sh \
	configs/config.yaml \
	./
RUN chmod 644 ./* && chmod +x *.sh \
	&& export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& /bin/bash ./install.sh \
	&& /bin/bash ./install_locale.sh \
	&& /bin/bash ./install_code.sh \
# Por último... Limpar cache do apt
	&& rm -rf /var/lib/apt/lists/*

# Copiar extensão pt-br e configuração do code-server, que não é possível fazer via script
# MAS DÁ PRA COPIAR HA HA HA (Será que pode dar problema com a versão do code-server?)
COPY --from=erickweil/container-vm:code-ptbr /opt/vscode-extensions /opt/vscode-extensions
COPY --from=erickweil/container-vm:code-ptbr /home/admin/.local/share/code-server /home/admin/.local/share/code-server

# Este entrypoint irá criar um novo usuário caso as variáveis de ambiente
# USERNAME e PASSWORD existam
ENTRYPOINT ["sh","/root/docker-entrypoint.sh"]
CMD ["/sbin/init", "--log-level=err"]

# ------------------------------------------------------------------
# Processo para gerar erickweil/container-vm:code-ptbr (só necessário se mudar como as extensões funcionam)
# (Comente as linhas do COPY Acima antes de fazer)
# Realizar build e arrumar as coisas iniciais
# docker build -t erickweil/container-vm:code .
# Executar container:
# docker rm -f vm01; docker run -d --name vm01 -p 3000:8080 --privileged erickweil/container-vm:code
# 1. Abre no navegador http://localhost:3000/ e instala a extensão ms-ceintl.vscode-language-pack-pt-br
# 2. Clicar botão para reiniciar com o locale pt-br
# 3. Escolher temas -> Modo escuro
# 4. Configuração "Terminal > Integrated: Allow Chords" desmarcar (Para funcionar crtl+k usando o nano) 
# NÃO. Arrumar as permissões da pasta de exntensões do code-server: chmod -R g=u /opt/vscode-extensions
# Aplicar container que foi modificado para ser uma imagem
# docker stop vm01; docker commit vm01 erickweil/container-vm:code-ptbr