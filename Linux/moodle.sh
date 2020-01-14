#!/bin/bash

## Exemplo de configuração de servidor para rodar o Moodle

echo "=============================="
echo "| UPGRADE DOS PACOTES/SO     |"
echo "=============================="
apt update
apt upgrade
apt dist-upgrade

echo "======================"
echo "| PACOTES ESSENCIAIS |"
echo "======================"
apt install -y git zip unzip

echo "=================="
echo "| BANCO DE DADOS |"
echo "=================="
apt install mariadb-server
mysql_secure_installation

echo "======================="
echo "| Servidor HTTP + PHP |"
echo "======================="
apt install -y apache2 php libapache2-mod-php
apt-get install -y php-mysql php-mbstring php-curl php-xml php-zip php-gd php-intl php-xmlrpc php-soap
