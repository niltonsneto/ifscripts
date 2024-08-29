#!/bin/bash

# Arquivo que contém a lista de IPs
ARQUIVO_IPS="ips.txt"

# Arquivo a ser enviado
ARQUIVO="/home/suporte/arquivo"

# Diretório de destino
DESTINO="/home/suporte/"

# Usuário SSH
USUARIO="suporte"

# Ler cada IP do arquivo e copiar o arquivo para cada um
while IFS= read -r IP; do
  echo "Enviando $ARQUIVO para $USUARIO@$IP:$DESTINO"
  scp "$ARQUIVO" "$USUARIO@$IP:$DESTINO"
done < "$ARQUIVO_IPS"
