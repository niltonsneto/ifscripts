#!/bin/bash

# Arquivo que contém a lista de IPs
ARQUIVO_IPS="ips.txt"

# Usuário SSH
USUARIO="suporte"

# Nome de host
NOME_HOST="lab"

# Ler cada IP do arquivo e atualizar o hostname
while IFS= read -r IP; do
  # Extrair o octeto final do IP
  OCTETO_FINAL=$(echo "$IP" | awk -F. '{print $NF}')
  
  # Conectar à máquina e atualizar o hostname
  echo "Conectando a $USUARIO@$IP e atualizando hostname para '$NOME_HOST-$OCTETO_FINAL'"
  ssh "$USUARIO@$IP" "sudo hostnamectl set-hostname $NOME_HOST-$OCTETO_FINAL && sudo hostnamectl set-hostname --static $NOME_HOST-$OCTETO_FINAL"
  
  # Opcional: Reiniciar o sistema para garantir que o hostname seja aplicado
  # echo "Reiniciando a máquina $USUARIO@$IP"
  # ssh "$USUARIO@$IP" "sudo reboot"
  
done < "$ARQUIVO_IPS"
