#!/bin/bash
########## Install AMP ###########
## Ok funcionando ultima atualização 08/10/2018
sudo apt update
##### Inicio repo PHP #####
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
##### Fim repo PHP #####
sudo apt install -y mysql-server mysql-client
sudo apt install -y  apache2 php7.2 libapache2-mod-php7.2 php7.2-common php7.2-cli php7.2-mongodb php-pear php7.2-dev php7.2-mysql php7.2-curl php7.2-gd php7.2-intl php-imagick php7.2-imap php-memcache  php7.2-pspell php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xmlrpc php7.2-xsl php7.2-mbstring php-gettext phpmyadmin
sudo pecl install mongodb
sudo echo "extension=mongodb.so" >> /etc/php/7.2/apache2/php.ini

###### Root access to PHPMyAdmin
##mysql -u root
##CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
##GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
##FLUSH PRIVILEGES;
##exit
#### Inicio instala postgreSQL
sudo apt install -y postgresql-10 postgresql-10-postgis-2.4


