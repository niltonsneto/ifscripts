#!/bin/bash
########## Install mongo ###########
## Ok funcionando ultima atualização 10/10/2018
sudo apt install -y curl  
sudo apt install -y libcurl3
sudo apt install -y libcurl4
##Create the list file /etc/apt/sources.list.d/mongodb-org-4.0.list
sudo touch /etc/apt/sources.list.d/mongodb-org-4.0.list
#### Inicio repositório #####
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
#### Fim repositório #####
sudo apt update
sudo apt install -y mongodb-org
sudo apt clean
##### Criando serviço de inicialização Mongo #####
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
sudo systemctl start mongodb
sudo systemctl enable mongodb
sudo systemctl stop mongodb
##### Fim serviço de inicialização Mongo #####

##### Configuração do mongod.conf ######
sudo rm /var/lib/mongodb
sudo rm /etc/mongod.conf
sudo mkdir /var/lib/mongodb
sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo cp /home/suporte/mongo/mongod_funfando /etc/mongod.conf
sudo systemctl start mongodb
##### Fim configuração do mongod.conf ######






