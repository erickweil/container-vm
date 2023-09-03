#!/bin/bash
if [[ ! $INSTALL_PROGRAMS == *"docker"* ]]; then exit 0; fi;

# Adiciona ao grupo docker, se existir
usermod -aG docker $USERNAME || true