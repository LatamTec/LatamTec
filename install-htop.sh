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

echo -e "\n\033[1;36mInstalando HTop en su Maquina"

sudo apt-get install htop -y

tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "Instalacion Completada HTOP" ; tput sgr0

