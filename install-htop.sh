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

figlet -f standard "Latam HTop" | lolcat
echo "Instalando HTop en su Maquina" | lolcat

sudo apt-get install htop -y

echo "Instalacion Completada" | lolcat
echo "Para abrir el Monitor use: sudo htop" | lolcat

