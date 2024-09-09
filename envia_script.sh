#!/bin/bash



clear
echo "*********************************************************************"
echo "*                                                                   *" 
echo "*                                                                   *" 
echo "*             SCRIPT PARA TRANSFERENCIA DE ARQUIVOS                 *" 
echo "*                                                                   *"
echo "*                                                                   *"
echo "*********************************************************************"
echo ""
echo ""
echo "Digite o nome do arquivo que deseja transferir:"
read nome_arquivo
# Verifica se o arquivo existe
if [ -e "$nome_arquivo" ]; then
   envia_arquivo "$nome_arquivo"
else
    clear
    echo "ERRO!! O arquivo '$nome_arquivo' não foi encontrado."
fi

envia_arquivo(){
# Arquivo que contém a lista de IPs
 ARQUIVO_IPS="ips.txt"
 NOME_ARQUIVO="$1"
# Arquivo a ser enviado
 ARQUIVO="/home/suporte/$NOME_ARQUIVO"
# Diretório de destino
 DESTINO="/home/suporte/"
# Usuário SSH
 USUARIO="suporte"
# Ler cada IP do arquivo e copiar o arquivo para cada um
while IFS= read -r IP; do
  echo "Enviando $ARQUIVO para $USUARIO@$IP:$DESTINO"
  scp "$ARQUIVO" "$USUARIO@$IP:$DESTINO"
done < "$ARQUIVO_IPS"
}
