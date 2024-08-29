#!/bin/bash
# Script para esconder lista de usuario no Ubuntu
# Versao 0.0.1
# Data ultima modificacao 04/12/2023
# Autor: Nilton S. Neto

touch /etc/dconf/profile/gdm
echo "user-db:user" > /etc/dconf/profile/gdm
echo "system-db:gdm" >> /etc/dconf/profile/gdm
echo "file-db:/usr/share/gdm/greeter-dconf-defaults" >> /etc/dconf/profile/gdm

mkdir /etc/dconf/db/gdm.d
touch /etc/dconf/db/gdm.d/00-login-screen

echo "[org/gnome/login-screen]" > /etc/dconf/db/gdm.d/00-login-screen
echo "disable-user-list=true" >> /etc/dconf/db/gdm.d/00-login-screen

dconf update
