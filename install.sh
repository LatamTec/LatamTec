#!/bin/bash

set -e

#
#  Latamtec Instalador @ KalixCloud
#
# Instalador de complementos para Servidores
# de minecraft en VPS UBUNTU | 18.04 20.04 |
#
#     Pagina Web: https://theboykiss.ovh

apt-get -y update
apt-get -y upgrade
apt-get -y autoremove
apt-get -y autoclean
apt-get -y install curl

LOG_PATH="/home/latamtec.log"

# Comprobar acceso ROOT
if [[ $EUID -ne 0 ]]; then
  echo "* Este script requiere de permisos de ROOT (sudo)." 1>&2
  exit 1
fi

output() {
  echo -e "* ${1}"
}

error() {
  COLOR_RED='\033[0;31m'
  COLOR_NC='\033[0m'

  echo ""
  echo -e "* ${COLOR_RED}ERROR${COLOR_NC}: $1"
  echo ""
}

execute() {
  echo -e "\n\n* LatamTec Instalador $(date) \n\n" >> $LOG_PATH

  bash <(curl -s "$1") | tee -a $LOG_PATH
  [[ -n $2 ]] && execute "$2"
}

done=false

echo -e "\n\033[1;36mMinecraft Instalador || By TheBoykissOld @ v1.0"
echo ""
echo -e "\n\033[1;36mCopyright (C) 2022, Luis Gonzales, <admin@theboykiss.cloud>"
echo -e "\n\033[1;36mhttps://github.com/LatamTec/LatamTec/"
echo ""
echo -e "\n\033[1;36mEste script no esta asociado con Minecraft Mojang"

############ RECURSOS NESECARIOS NO ELIMINAR #

JAVA_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-java.sh"

MYSQL_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-mysql.sh"

PHPMYADMIN_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-phpmyadmin.sh"

HTOP_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-htop.sh"

SPIGOT_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install.sh"

############ RECURSOS NESECARIOS NO ELIMINAR #

while [ "$done" == false ]; do
  options=(
    "Instalar Java (Se instalaran Java 8 11 y 16)"
    "Instalar MySQL"

    "Instalar PhPMyAdmin"
    "Instalar Monitor HTOP (Monitor de Consumo)"
    "Instalar Descargar Spigot (Versiones 1.7 - 1.18)"

    "Instalar Todo (Aun no Disponible)"
  )

  actions=(
    "$JAVA_INSTALL"
    "$MYSQL_INSTALL"
    "$PHPMYADMIN_INSTALL"

    "$HTOP_INSTALL"
    "$SPIGOT_INSTALL"

    "$INSTALL"
  )

  echo "Selecciona una Opcion:"

  for i in "${!options[@]}"; do
    output "[$i] ${options[$i]}"
  done

  echo -n "* Opcion 0-$((${#actions[@]} - 1)): "
  read -r action

  [ -z "$action" ] && error "Ingrese una Opcion valida" && continue

  valid_input=("$(for ((i = 0; i <= ${#actions[@]} - 1; i += 1)); do echo "${i}"; done)")
  [[ ! " ${valid_input[*]} " =~ ${action} ]] && error "Opcion invalida"
  [[ " ${valid_input[*]} " =~ ${action} ]] && done=true && IFS=";" read -r i1 i2 <<< "${actions[$action]}" && execute "$i1" "$i2"
done
