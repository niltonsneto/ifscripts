#!/bin/bash

#########################################################################
# INSTITUTO FEDERAL DE EDUCAÇÃO CATARINENSE - IFC                       #
# CAMPUS - ARAQUARI                                                     #
#                                                                       #
#     SCRIPT DE INSTALAÇÃO DE SOFTWARES PARA OS LABS DE INFORMÁTICA     #
#                                                                       #
#  AUTOR: NILTON DOS SANTOS NETO TAE/LAB.INFO.                          #
#                                                                       #
#  VERSÃO: 1.0.1                                                        #
#  DATA ÚLTIMA ATUALIZAÇÃO: 06/09/2018                                  #
#                                                                       #
#########################################################################

                                                                    #

main(){
clear
echo "Instalador de pacotes"
echo "Preparando a máquina para instalar....."
if ! sudo apt update
then
  echo "Erro ao tentar executar update, verificar captive"
  exit 1
fi
echo "Atualizando a máquina...."
if ! sudo apt upgrade -y
then
  echo "Erro ao tentar executar upgrade"
  exit 1
fi
clear
echo "Instalando pacotes básicos..."
basico
repo
clear
echo "Iniciando instalação dos Pacotes..."
#mongo_inst
#editores
#python
#seguranca
#redesWiFi
#redes
#node
#qgis
#rStudio
#docker
web2
#outros

}

### Atualiza ##
atual(){
  sudo apt update
  sudo apt upgrade -y
}

#### Repositorios #####
repo(){
clear
echo "Verificando e atualizando repositórios....."
### Mongo ####
 touch /etc/apt/sources.list.d/mongodb-org-4.0.list
 sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
 echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
### Fim Mongo ####
### PostrgreSQL ###
  if ! ls /etc/apt/sources.list.d/postgresql.list
    then
      echo "Arquivo postgresql.list não encontrado!!"
      
  fi
  read -p"Deseja instalar o PostgreSQL?(s/n)" op
  if [ $op = "s" ]
    then
      echo "Iniciando a instalação...."
      touch /etc/apt/sources.list.d/postgresql.list
      sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/postgresql.list'
      wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
      atual
      sudo apt install -y postgresql-10
  fi
### Fim PostgreSQL ####
atual
}
#### Pacotes básicos #####
basico(){
  sudo apt install -y build-essential openssh-server openssh-client lynx
}
###### LATEX ########
editores(){
sudo apt install -y texlive-full texlive-lang-portuguese babel latex-beamer abntex aspell-pt-br gedit-latex-plugin rubber texmaker texlive-latex-extra latex-beamer texlive-extra-utils texlive-generic-extra texlive-lang-portuguese texlive-latex-extra texlive-math-extra  texlive-humanities texlive-latex-recommended abntex aspell-pt-br gedit-plugins gedit texlive-pictures texlive-plain-extra texlive-publishers texlive-science kile-l10n kile texlive-latex-extra texlive-fonts-recommended geany gedit gedit-plugins geany-plugins
}

##### Laboratórios - Python ######
python(){
sudo apt install -y ipython3 virtualenvwrapper python3-minimal python3-requests python3-venv python3-bottle python3-flask python3-setuptools python3-simplejson python3-tk dreampie bpython3 python3-pip python-pip

#sudo apt install -y sqlite3 sqliteman git
#sudo pip install pip --upgrade
#sudo pip install setuptools --upgrade
#sudo pip install simpy --upgrade
#sudo pip install bcrypt --upgrade
#sudo pip install Django --upgrade
#sudo pip install psycopg2 --upgrade
#sudo pip install virtualenv --upgrade
#sudo pip install virtualenvwrapper --upgrade
#sudo pip install eagle graphics.py graphics.py-extra rows
}
##Ferramentas de segurança
seguranca(){
sudo apt install -y wireshark netcat nikto john steghide john-data nmap dia dia-shapes
}
### Ferramentas redes sem fio
redesWiFi(){
sudo apt install -y kismet wifite aircrack-ng
}
### Ferramentas redes desempenho
redes(){
sudo apt install -y iperf tcptraceroute jmeter jmeter-ftp jmeter-tcp  jmeter-ldap jmeter-http putty
}
#### Node JS
node(){
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
}
### Weka e qgis
qgis(){
sudo apt install -y weka qgis
}
### Base para o r-studio (tem que instalar um deb)
rStudio(){
apt install -y r-base
}
#### WEB ####
web(){
  sudo apt install -y snmp mongodb-org apache2 php7.0 php7.0-common php7.0-gd php7.0-json php7.0-odbc php7.0-readline php7.0-sybase php7.0-zip php7.0-bcmath php7.0-curl php7.0-gmp php7.0-ldap php7.0-opcache php7.0-recode php7.0-tidy php7.0-bz2 php7.0-dev php7.0-imap php7.0-mbstring php7.0-pgsql php7.0-snmp php7.0-xml php7.0-cgi php7.0-enchant php7.0-interbase php7.0-mcrypt php7.0-phpdbg php7.0-soap php7.0-xmlrpc php7.0-cli php7.0-fpm php7.0-intl php7.0-mysql php7.0-pspell php7.0-sqlite3 php7.0-xsl php-dev libapache2-mod-php libapache2-mod-php7.0 libapache2-mod-python libapache2-mod-auth-pgsql libcurl4-doc libcurl4-openssl-dev php-mongodb php-raphf php-raphf-dev php-pecl-http php-pecl-http-dev php-http php-http-request php-http-request2 php-http-webdav-server php-propro php-propro-dev php-pear composer mysql-client-5.7 mysql-server-5.7 libmysqlclient-dev php-gettext php7.0-mysql php7.0-curl php7.0-json php7.0-cgi php7.0 pgadmin3 phpmyadmin mysql_secure_installation
  sudo echo "extension=raphf.so" >> /etc/php/7.2/apache2/php.ini
  sudo echo "extension=propro.so" >> /etc/php/7.2/apache2/php.ini
  sudo echo "extension=http.so" >> /etc/php/7.2/apache2/php.ini
  sudo echo "extension=mongodb.so" >> /etc/php/7.2/apache2/php.ini
  sudo pear install pear
  sudo sed -i "$ s|\-n||g" /usr/bin/pecl
  sudo apt install -y pkg-config
  sudo pecl install mongodb raphf pecl_http propro
}
web2(){
sudo apt-get -y install snmp mysql-server mysql-client apache2 libapache2-mod-php7.2 php7.2 php7.2-cgi php7.2-cli php7.2-common php7.2-curl php7.2-dev php7.2-json php7.2-mysql php7.2-pgsql php7.2-pspell php7.2-readline php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xml php7.2-xmlrpc php-geoip php-xdebug php-ds php-gmagick php-http php-igbinary php-imagick php-memcache php-memcached php-mongodb php-oauth php-propro php-uuid php-yaml php7.2-bcmath php7.2-bz2 php7.2-dba php7.2-enchant php7.2-fpm php7.2-imap php7.2-interbase php7.2-intl php7.2-mbstring php7.2-phpdbg php7.2-soap php7.2-xsl php7.2-zip php-gettext php7.2-snmp php-raphf php7.2-sybase php-all-dev libapache2-mod-python libapache2-mod-auth-pgsql libcurl4-doc libcurl4-openssl-dev composer phpmyadmin
}
mongo_inst(){
sudo update
sudo apt install -y mongodb-org
sudo su
sudo echo "[Unit]" > /etc/systemd/system/mongodb.service
sudo echo "Description=High-performance, schema-free document-oriented database" >> /etc/systemd/system/mongodb.service
sudo echo "After=network.target" >> /etc/systemd/system/mongodb.service
sudo echo "" >> /etc/systemd/system/mongodb.service
sudo echo "[Service]" >> /etc/systemd/system/mongodb.service
sudo echo "User=mongodb" >> /etc/systemd/system/mongodb.service
sudo echo "ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf" >> /etc/systemd/system/mongodb.service
sudo echo "" >> /etc/systemd/system/mongodb.service
sudo echo "[Install]" >> /etc/systemd/system/mongodb.service
sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/mongodb.service
exit
sudo systemctl start mongodb
sudo systemctl enable mongodb
}
#### Docker #####
docker(){
  if which docker
  then
    clear
    echo "Removendo docker encontrado...."
    sudo apt remove docker docker-engine
  fi
  echo "Preparando para instalar Docker....."
  sudo apt install -y apt-transport-https ca-certificates software-properties-common
  atual
  sudo apt install -y docker-ce
}

#### Outros ######
outros(){
  sudo apt install -y ubuntu-make bum htop
}

#### Configura ######
config(){
  sudo phpenmod mcrypt
  sudo phpenmod mbstring
***** config do apache ******
sudo echo "<IfModule mod_dir.c>" > /etc/apache2/mods-enabled/dir.conf
sudo echo "    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm" >> /etc/apache2/mods-enabled/dir.conf
sudo echo "</IfModule>" >> /etc/apache2/mods-enabled/dir.conf
mkdir /home/aluno/public_html
sudo chmod a+x /home/aluno/public_html
sudo chown -R www-data:www-data /home/aluno/public_html
sudo chmod -R 775 /home/aluno/public_html
sudo adduser $USER www-data
sudo adduser aluno www-data
sudo a2enmod userdir
sudo systemctl restart apache2
sudo sed -i "21 c \#<IfModule mod_userdir.c>" /etc/apache2/mods-available/php7.0.conf
sudo sed -i "22 c \#    <Directory /home/*/public_html>" /etc/apache2/mods-available/php7.0.conf
sudo sed -i "23 c \#        php_admin_flag engine Off" /etc/apache2/mods-available/php7.0.conf
sudo sed -i "24 c \#    </Directory>" /etc/apache2/mods-available/php7.0.conf
sudo sed -i "25 c \#</IfModule>" /etc/apache2/mods-available/php7.0.conf
sudo sed -i "12 c \        DocumentRoot /home/aluno/public_html/" /etc/apache2/sites-available/000-default.conf
sudo sed -i "158 a \<Directory /home/aluno/public_html/>" /etc/apache2/apache2.conf
sudo sed -i "159 a \        Options Indexes FollowSymLinks" /etc/apache2/apache2.conf
sudo sed -i "160 a \        AllowOverride None" /etc/apache2/apache2.conf
sudo sed -i "161 a \        Require all granted" /etc/apache2/apache2.conf
sudo sed -i "162 a \</Directory>" /etc/apache2/apache2.conf
sudo sed -i "163 a \ " /etc/apache2/apache2.conf
sudo a2enmod rewrite
sudo systemctl restart apache2
sudo echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
sudo echo "ServerName localhost" >> /etc/apache2/apache2.conf
}
####Pycharm e PHPStorm
#apt -y install pencil
#umake ide pycharm-professional
#umake ide phpstorm

main
