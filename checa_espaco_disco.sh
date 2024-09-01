#!/bin/bash

# Diretório que você deseja verificar
dir_to_check="/home"

# Script a ser executado se a condição for atendida
script_to_run="/path/to/your_script.sh"

# Espaço livre necessário (3 GB em KB)
required_space=$((3 * 1024 * 1024))

# Verifica o espaço livre no diretório especificado
free_space=$(df --output=avail "$dir_to_check" | tail -n1)

if [ "$free_space" -ge "$required_space" ]; then
    echo "Espaço livre suficiente em $dir_to_check. Executando o script..."
    bash "$script_to_run"
else
    echo "Espaço livre insuficiente em $dir_to_check. Não executando o script."
fi
