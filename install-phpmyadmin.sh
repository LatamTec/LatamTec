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

figlet -f standard "Latam PhPMyAdmin" | lolcat
echo "Instalando PhPMyAdmin en su Maquina" | lolcat

sudo apt-get install apache2 -y
sudo service apache2 restart

sudo apt-get install phpmyadmin -y
sudo ln -s /usr/share/phpmyadmin /var/www/html/
sudo apt-get install php-mbstring php7.0-mbstring php-gettext libapache2-mod-php7.0

echo "Instalacion Completada" | lolcat