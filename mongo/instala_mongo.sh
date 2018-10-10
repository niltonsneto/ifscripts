#!/bin/bash
########## Install mongo ###########
## Ok funcionando ultima atualização 08/10/2018
sudo apt update
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

##### Configura serviço para subir mongo no boot

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

#Agora entrar no mongo, usando a linha de comando, e execute os comandos para criar os usuarios para a autenticação:
mongo
use ifc
j = { name : "mongo" }
k = { x : 3 }
db.alunos.insert( j )
db.alunos.insert( k )
db.alunos.find()
db.alunos.find().pretty()
db.createUser(
   {
     user: "aluno",
     pwd: "aluno",
     roles: [ "readWrite", "dbAdmin" ]
   }
)
use admin
db.createUser(
   {
     user: "root",
     pwd: "root",
     roles: [ "root" , "userAdminAnyDatabase", "dbAdminAnyDatabase" , "readWriteAnyDatabase", "readAnyDatabase"]
   }
)

exit

#De agora em diante usaremos ( mongo --port 27017 -u aluno -p aluno --authenticationDatabase ifc ) para quando formos acessar como aluno a base de dados ifc, e quando formos acessar qualquer base de dados usaremos ( mongo --port 27017 -u root -p root --authenticationDatabase admin ):
#Agora vamos voltar a usar o mongo só que agora como root, usando o comando a seguir:
mongo --port 27017 -u root -p root --authenticationDatabase admin


#Agora que temos o usuario root, vamos setar o mongo com antentificação. Agora em security.authorization: disabled, subistitua por enabled;

sudo sed -i "85 s/disabled/enabled/" /etc/mongod.conf


#Agora vamos reiniciar o servidor mongo, usando o comando:
sudo systemctl restart mongodb


#Agora vamos iniciar o mongo, usando o comando:
mongo --port 27017 -u root -p root --authenticationDatabase admin


cd /home/aluno/public_html/
sudo composer require "mongodb/mongodb=^1.0.0"
