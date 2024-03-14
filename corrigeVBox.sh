#!/bin/bash
# Script para instalacao padrao no Ubuntu
# Versao 0.0.1
# Data ultima modificacao 13/03/2024
# Autor: Nilton S. Neto

add-apt-repository ppa:ubuntu-toolchain-r/ppa -y
apt update
apt install g++-12 gcc-12
/sbin/vboxconfig 
