#!/bin/bash

set -e

sudo apt-get install apache2 -y
apt-get -y install certbot
sudo apt install certbot python3-certbot-apache -y

#
#  Latamtec Instalador @ KalixCloud
#
# Instalador de complementos para Servidores
# de minecraft en VPS UBUNTU | 18.04 20.04 |
#
#     Pagina Web: https://theboykiss.ovh
#

######## General checks #########

if [[ $EUID -ne 0 ]]; then
  echo "* Este script requiere de permisos de ROOT (sudo)." 1>&2
  exit 1
fi

echo -e "\n\033[1;36mInstalando PhPMyAdmin en su Maquina"
echo -e "\n\033[1;36mNo tienes un dominio? puedes adquirir uno gratis aqui: https://freenom.com"
echo -e "\n\033[1;36mPorfavor ingrese un Dominio (mysql.example.ovh):"
read -r FQDN
echo -e "\n\033[1;36mPorfavor ingrese un Correo (example@example.ovh):"
read -r email
echo ""

certbot --apache --redirect --no-eff-email --email "$email" --agree-tos -d "$FQDN"
sudo service apache2 restart

sudo apt-get install phpmyadmin -y
sudo ln -s /usr/share/phpmyadmin /var/www/html/
sudo apt-get install php-mbstring php7.0-mbstring php-gettext libapache2-mod-php7.0

echo -e "\n\033[1;36mInstalacion Completada"
echo -e "Host: https://$FQDN/phpmyadmin"
