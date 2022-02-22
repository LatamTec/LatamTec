#!/bin/bash

set -e

#
#  Latamtec Instalador @ KalixCloud
#
# Instalador de complementos para Servidores
# de minecraft en VPS UBUNTU | 18.04 20.04 |
#
#     Pagina Web: www.luistec.cloud


inst_components () {
[[ $(dpkg --get-selections|grep -w "nano"|head -1) ]] || apt-get install nano -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "figlet"|head -1) ]] || apt-get install figlet -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "screen"|head -1) ]] || apt-get install screen -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python"|head -1) ]] || apt-get install python -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "python3"|head -1) ]] || apt-get install python3 -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "curl"|head -1) ]] || apt-get install curl -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "ufw"|head -1) ]] || apt-get install ufw -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "unzip"|head -1) ]] || apt-get install unzip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "zip"|head -1) ]] || apt-get install zip -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "lolcat"|head -1) ]] || apt-get install lolcat -y &>/dev/null
[[ $(dpkg --get-selections|grep -w "apache2"|head -1) ]] || {
 apt-get install apache2 -y &>/dev/null
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 }
apt-get install python-pip build-essential python-dev &>/dev/null
pip install Glances &>/dev/null
pip install PySensors &>/dev/null
}

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

output "Latamtec Instalador script @ v1.0"
output
output "Copyright (C) 2022, Luis Gonzales, <contacto@network.luistec.cloud>"
output "https://github.com/latamtec/install.sh"
output
output "Este script no esta asociado con Minecraft Mojang"

# RECURSOS NESECARIOS NO ELIMINAR #

JAVA_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-java.sh"

MYSQL_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-mysql.sh"

PHPMYADMIN_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-phpmyadmin.sh"

HTOP_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install-htop.sh"

SPIGOT_INSTALL="https://raw.githubusercontent.com/LatamTec/LatamTec/main/install.sh"

#RECURSOS NESECARIOS NO ELIMINAR #

while [ "$done" == false ]; do
  options=(
    "Instalar Java (Se instalaran Java 8 11 y 16)"
    "Instalar MySQL"

    "Instalar PhPMyAdmin"
    "Instalar Monitor HTOP"
    "Instalar Descargar Spigot (Versiones Soportadas 1.7 - 1.18)"

    "Instalar Todo (Java, PhPMyAdmin, UFW, Spigot, Mysql)"
  )

  actions=(
    "$JAVA_INSTALL"
    "$MYSQL_INSTALL"
    "$PHPMYADMIN_INSTALL"

    "$HTOP_INSTALL"
    "$SPIGOT_INSTALL"

    "$JAVA_INSTALL;$MYSQL_INSTALL;$PHPMYADMIN_INSTALL;$UFW_INSTALL;$SPIGOT_INSTALL"
  )

  output "Selecciona una Opcion:"

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
