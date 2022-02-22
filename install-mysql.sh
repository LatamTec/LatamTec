#!/bin/bash

set -e

#
#  Latamtec Instalador @ KalixCloud
#
# Instalador de complementos para Servidores
# de minecraft en VPS UBUNTU | 18.04 20.04 |
#
#     Pagina Web: www.luistec.cloud
#

######## General checks #########

# exit with error status code if user is not root
if [[ $EUID -ne 0 ]]; then
  echo "* Este script requiere de permisos de ROOT (sudo)." 1>&2
  exit 1
fi

figlet -f standard "Latam MySql" | lolcat
echo "Instalando MySQL en su Maquina" | lolcat

sudo apt-get install mysql-server mysql-common mysql-client

echo "Enter a password" | lolcat
sudo mysql_secure_installation

echo "Instalacion Completada" | lolcat
