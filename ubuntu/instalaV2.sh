#!/bin/bash
# Script para instalação padrão no Ubuntu
# Versão 1.0.0
# Data última modificação 13/09/2024
# Autor: Nilton S. Neto

# Verificar se o dialog está instalado
if ! command -v dialog &> /dev/null; then
    echo "O pacote 'dialog' não está instalado. Instalando..."
    sudo apt update
    sudo apt install -y dialog
fi

# Funções de instalação
instala_pacotes_basicos() {
    echo "Instalando pacotes básicos..."
    sudo apt update
    sudo apt install -y build-essential lynx curl git-all putty openssh-server traceroute wireshark python3-dev graphviz flatpak wine
}

instala_vscode() {
    echo "Instalando VScode..."
    wget -q https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
    sudo dpkg -i vscode.deb
    sudo apt -f install -y
    rm -f vscode.deb
}

instala_mongo() {
    echo "Instalando MongoDB..."
    wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
    sudo apt update
    sudo apt install -y mongodb-org
    sudo systemctl start mongod
    sudo systemctl enable mongod
}

instala_mysql() {
    echo "Instalando MySQL..."
    sudo apt update
    sudo apt install -y mysql-server mysql-client
}

instala_postgresql() {
    echo "Instalando PostgreSQL..."
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt update
    sudo apt install -y postgresql postgis
}

instala_pgAdmin4() {
    echo "Instalando PgAdmin4..."
    curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
    echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" | sudo tee /etc/apt/sources.list.d/pgadmin4.list
    sudo apt update
    sudo apt install -y pgadmin4-desktop
}

instala_docker() {
    echo "Instalando Docker..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Instalando Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

instala_packettracer() {
    echo "Instalando Packet Tracer..."
    sudo apt install -f ./CiscoPacketTracer_821_Ubuntu_64bit.deb
}

instala_rstudio() {
    echo "Instalando R e RStudio..."
    sudo apt install -y software-properties-common dirmngr
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo apt-key add -
    sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
    sudo apt update
    sudo apt install -y r-base
    wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.09.1-494-amd64.deb
    sudo apt install -f ./rstudio-2023.09.1-494-amd64.deb
    rm -f rstudio-2023.09.1-494-amd64.deb
}

instala_vbox() {
    echo "Instalando VirtualBox..."
    wget -qO- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
    sudo apt update
    sudo apt install -y virtualbox-6.1
}

instala_via_snap() {
    echo "Instalando pacotes via Snap..."
    sudo snap install gimp inkscape arduino mysql-workbench-community
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak install -y flathub com.adobe.Reader
}

instala_veyon() {
    echo "Instalando Veyon..."
    sudo add-apt-repository ppa:veyon/stable
    sudo apt update
    sudo apt install -y veyon
}

instala_android_studio() {
    echo "Instalando Android Studio..."
    sudo apt install -y openjdk-11-jdk
    sudo add-apt-repository ppa:maarten-fonville/android-studio
    sudo apt update
    sudo apt install -y android-studio
}

instala_redes() {
    echo "Instalando ferramentas de redes..."
    sudo apt install -y iperf traceroute tcpdump nmap tftp net-tools p7zip-full p7zip-rar
    wget https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v10.6.1/phoronix-test-suite_10.6.1_all.deb -O phoronix.deb
    sudo apt install -f ./phoronix.deb
}

instala_grub_customizer() {
    echo "Instalando Grub Customizer..."
    sudo add-apt-repository ppa:danielrichter2007/grub-customizer
    sudo apt update
    sudo apt install -y grub-customizer
}

# Exibir menu usando dialog
exibir_menu() {
    dialog --backtitle "IFC - Campus Araquari" --title "Menu de Instalação" \
        --menu "Escolha uma opção" 15 50 10 \
        1 "Instalar Pacotes Básicos" \
        2 "Instalar VSCode" \
        3 "Instalar MongoDB" \
        4 "Instalar MySQL" \
        5 "Instalar PostgreSQL" \
        6 "Instalar PgAdmin4" \
        7 "Instalar Docker" \
        8 "Instalar Packet Tracer" \
        9 "Instalar R e RStudio" \
        10 "Instalar VirtualBox" \
        11 "Instalar Pacotes via Snap" \
        12 "Instalar Veyon" \
        13 "Instalar Android Studio" \
        14 "Instalar Ferramentas de Redes" \
        15 "Instalar Grub Customizer" \
        0 "Sair" 2> /tmp/opcao_selecionada

    opcao=$(< /tmp/opcao_selecionada)
    rm -f /tmp/opcao_selecionada

    case $opcao in
        1) instala_pacotes_basicos ;;
        2) instala_vscode ;;
        3) instala_mongo ;;
        4) instala_mysql ;;
        5) instala_postgresql ;;
        6) instala_pgAdmin4 ;;
        7) instala_docker ;;
        8) instala_packettracer ;;
        9) instala_rstudio ;;
        10) instala_vbox ;;
        11) instala_via_snap ;;
        12) instala_veyon ;;
        13) instala_android_studio ;;
        14) instala_redes ;;
        15) instala_grub_customizer ;;
        0) exit 0 ;;
        *) dialog --msgbox "Opção inválida" 5 30 ;;
    esac
}

# Exibir o menu em loop até o usuário escolher sair
while true; do
    exibir_menu
done
