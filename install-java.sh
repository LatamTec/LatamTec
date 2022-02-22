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

apt update; apt upgrade -y

figlet -f standard "LatamTec Install" | lolcat

sudo apt install openjdk-8-jdk -y

sudo apt install openjdk-11-jdk

# Install Java 16
sudo add-apt-repository ppa:linuxuprising/java
sudo apt install oracle-java16-installer
# Install Java 16

echo "Instalacion Completada" | lolcat