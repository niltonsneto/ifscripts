#!/bin/bash
# Script para instalacao padrao no Ubuntu
# Versao 0.0.2
# Data ultima modificacao 13/03/2024
# Autor: Nilton S. Neto

#https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse ou https://repo.mongodb.org/apt/$(lsb_release -cs)/mongodb-org/6.0 multiverse

#usar mongosh

instala_basico() {
    echo "Instalando pacotes basicos......"
    sleep 2
    #apt update
    #apt upgrade
    #apt dist-upgrade
    apt install  build-essential lynx curl git-all putty openssh-server traceroute wireshark python3-dev graphviz flatpak wine
    #flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    echo "******* Pacotes basicos instalados *******"
    sleep 2
    #clear
}

instala_vscode() {
    echo "Intalando VScode......"
    sleep 2
    dpkg -i code_1.84.2-1699528352_amd64.deb
    rm -rf code_1.84.2-1699528352_amd64.deb
    echo "Pacote instalado"
    sleep 2
    clear
}

instala_mongo() {
    echo "Instalando MongoDB......"
    sleep 2
    wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
    apt update
    apt install -y mongodb-org
    service mongod start
    service mongod enable
    echo "******* MongoDB instalado *******"
    sleep 2
    clear
}

instala_mysql() {
    echo "Instalando Mysql......"
    sleep 2
    apt install -y mysql-server mysql-client
    echo "******* Mysql instalado *******"
    sleep 2
    clear
}

instala_postgresql() {
    echo "Instalando PostgreSQL......"
    sleep 2
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt jammy-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    apt-get update
    apt-get -y install postgresql postgis
    echo "pt_BR.UTF-8 UTF-8" | sudo tee /etc/locale.gen
    echo "******* PostgreSQL instalado *******"
    sleep 2
    clear
}

instala_pgAdmin4() {
    echo "Instalando PgAdmin4......"
    sleep 2
    curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
    sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
    apt update
    apt -y install pgadmin4-desktop
    echo "******* PostgreSQL instalado *******"
    sleep 2
    clear
}

instala_docker() {
    echo "Instalando Docker......"
    sleep 2
    apt install apt-transport-https ca-certificates gnupg-agent software-properties-common
    #curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
    apt update
    #apt -y install docker-ce
    apt install docker.io
    echo "******* Docker instalado *******"
    sleep 2
    echo "Instalando Docker compose......"
    curl -s https://api.github.com/repos/docker/compose/releases/latest | grep browser_download_url | grep docker-compose-linux-x86_64 | cut -d '"' -f 4 | wget -qi -
    chmod +x docker-compose-linux-x86_64
    mv docker-compose-linux-x86_64 /usr/local/bin/docker-compose
    echo "******* Docker compose instalado *******"
    sleep 2
    clear
}

instala_packettracer() {
    echo "Instalando Packettracer......"
    sleep 2
    apt install -f ./CiscoPacketTracer_821_Ubuntu_64bit.deb
    #rm -rf CiscoPacketTracer_821_Ubuntu_64bit.deb
    echo "******* Packettracer instalado *******"
    sleep 2
    #clear
}

instala_rstudio() {
    echo "Instalando R......"
    sleep 2
    apt -y install --no-install-recommends software-properties-common dirmngr
    wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.as
    sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
    apt update
    sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
    apt update
    sudo apt install --no-install-recommends r-base
    echo "Instalando RStudio......"
    sleep 2
    wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.09.1-494-amd64.deb
    sleep 2
    apt install -f ./rstudio-2023.09.1-494-amd64.deb
    rm -rf rstudio-2023.09.1-494-amd64.deb
    echo "******* RStudio instalado *******"
    sleep 2
    clear
}

instala_vbox() {
    echo "Instalando VirtualBox......"
    sleep 2
    sudo echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib" >>/etc/apt/sources.list
    sudo gpg --dearmor oracle_vbox_2016.asc --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
    wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
    apt-get update
    apt-get install virtualbox-6.1
    echo "******* VirtualBox instalado *******"
    sleep 2
    clear

}

instala_viaSnap() {
    echo "Instalando pacotes via snap......"
    sleep 2
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    snap install gimp
    snap install inkscape
    #snap install geogebra
    #flatpak install flathub org.inkscape.Inkscape
    #flatpak install flathub org.audacityteam.Audacity
    #####Desenvolvimento
    snap install arduino
    snap install mysql-workbench-community
    ####Editores de texto
    flatpak install flathub com.adobe.Reader
    flatpak run com.adobe.Reader
    ####Educativos
    #flatpak install flathub org.qgis.qgis
    #flatpak install flathub org.geogebra.GeoGebra
    #####Sistema
    #flatpak install flathub org.filezillaproject.Filezilla
    echo "******* Instalacoes concluidas!!! *******"
    sleep 2
    clear

}

instala_veyon() {
    echo "Instalando Veyon......"
    sleep 2
    add-apt-repository ppa:veyon/stable
    apt update
    apt install -y veyon
    echo "******* Veyon instalado *******"
    sleep 2
    clear
}

instala_androidStudio() {
    echo "Instalando androidStudio......"
    sleep 2
    apt install openjdk-11-jdk
    add-apt-repository ppa:maarten-fonville/android-studio
    apt update
    apt install android-studio
    echo "*******  androidStudio *******"
    sleep 2
    clear
}

instala_redes() {
    echo "Instalando Redes......"
    sleep 2
    apt install iperf traceroute tcpdump nmap tftp net-tools p7zip-full p7zip-rar
    wget https://github.com/phoronix-test-suite/phoronix-test-suite/releases/download/v10.6.1/phoronix-test-suite_10.6.1_all.deb -O phoronix.deb
    apt install -f ./phoronix.deb
    echo "******* Redes instalado *******"
    sleep 2
    clear
}

instala_grubCustomizer() {
    echo "Intalando Grubcustomizer......"
    sleep 2
    add-apt-repository ppa:danielrichter2007/grub-customizer
    apt update
    apt install grub-customizer
    echo "Pacote instalado"
    sleep 2
    clear
}

#instala_basico
#instala_vscode
#instala_veyon
#instala_mongo
#instala_postgresql
#instala_mysql
#instala_pgAdmin4
#instala_docker
#instala_packettracer
#instala_rstudio
#instala_vbox
#instala_androidStudio
#instala_redes
instala_grubCustomizer
instala_viaSnap

