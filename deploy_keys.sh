#!/bin/bash

# Arquivo que contém a lista de IPs ou nomes de máquinas
ARQUIVO_IPS="ips.txt"

# Caminho para a chave pública
CHAVE_PUBLICA="~/.ssh/id_rsa.pub"

# Usuário SSH
USUARIO="usuario"

# Ler cada IP do arquivo e copiar a chave pública
while IFS= read -r IP; do
  echo "Copiando chave pública para $USUARIO@$IP"
  ssh-copy-id -i "$CHAVE_PUBLICA" "$USUARIO@$IP"
done < "$ARQUIVO_IPS"


##########################################
# OBSERVAÇAO:Antes de executar o script, #
# dar as seguintes permissoes:           #
#  chmod 700 ~/.ssh                      #
#  chmod 600 ~/.ssh/authorized_keys      #
##########################################
