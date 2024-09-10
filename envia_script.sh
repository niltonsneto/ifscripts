#!/bin/bash
# Define o título da janela e o título de fundo
WINDOW_TITLE="Envia Arquivos"
BACKTITLE="IFC - Campus Araquari"

    dialog --backtitle "$BACKTITLE" --title "$WINDOW_TITLE" --msgbox "Bem-vindo ao sistema de envio de arquivos via SCP.\n\nEste script irá ajudá-lo a enviar um arquivo para uma lista de IPs." 15 50

FILE_NAME=$(dialog --backtitle "$BACKTITLE" --title "$WINDOW_TITLE" --inputbox "Digite o nome do arquivo:" 10 50 --stdout)

if [ $? -ne 0 ]; then
   dialog --backtitle "$BACKTITLE" --title "Cancelada" --sleep 3 --infobox "Operação cancelada!" 5 25
   clear
   exit 1  
fi    

# Verifica se o arquivo existe
if [ ! -e "$FILE_NAME" ]; then
    dialog --backtitle "$BACKTITLE" --title "Erro!!" --sleep 3 --infobox "O arquivo '$FILE_NAME' não existe." 10 50
    clear
    exit 1
fi
# Arquivo que contém a lista de IPs
 ARQUIVO_IPS="ips.txt"
 clear
# Arquivo a ser enviado
 ARQUIVO="/home/suporte/$FILE_NAME"
# Diretório de destino
 DESTINO="/home/suporte/"
# Usuário SSH
 USUARIO="suporte"
# Ler cada IP do arquivo e copiar o arquivo para cada um
while IFS= read -r IP; do
  echo "Enviando $ARQUIVO para $USUARIO@$IP:$DESTINO"
  scp "$ARQUIVO" "$USUARIO@$IP:$DESTINO"
done < "$ARQUIVO_IPS"
