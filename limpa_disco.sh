#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$(id -u)" -ne "0" ]; then
    echo "Este script deve ser executado como root."
    exit 1
fi

# Diretório base dos usuários
home_dir="/home"

# Nome do usuário que não deve ter seus arquivos excluídos
exempt_user="suporte"

# Listar todos os usuários no sistema
for user in $(cut -d: -f1 /etc/passwd); do
    # Verifica se o diretório home do usuário existe
    user_home="${home_dir}/${user}"
    if [ -d "$user_home" ]; then
        # Verifica se o usuário não é o usuário exempt_user
        if [ "$user" != "$exempt_user" ]; then
            echo "Limpando arquivos em $user_home..."
            # Remove todos os arquivos dentro do diretório do usuário, mas preserva o diretório
            find "$user_home" -type f -exec rm -f {} \;
        else
            echo "Pular exclusão de arquivos para o usuário $user."
        fi
    else
        echo "O diretório home para o usuário $user não existe."
    fi
done

echo "Operação concluída."
