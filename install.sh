#!/bin/bash

set -e

#
#  Latamtec Instalador @ KalixCloud
#
# Instalador de complementos para Servidores
# de minecraft en VPS UBUNTU | 18.04 20.04 |
#
#     Pagina Web: www.luistec.cloud

sudo apt install figlet -y
sudo apt install lolcat -y

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

JAVA_INSTALL="$GITHUB_BASE_URL/$SCRIPT_VERSION/install-panel.sh"

MYSQL_INSTALL="$GITHUB_BASE_URL/$SCRIPT_VERSION/install-wings.sh"

PHPMYADMIN_INSTALL="$GITHUB_BASE_URL/$SCRIPT_VERSION/legacy/panel_0.7.sh"

HTOP_INSTALL="$GITHUB_BASE_URL/$SCRIPT_VERSION/legacy/daemon_0.6.sh"

SPIGOT_INSTALL="$GITHUB_BASE_URL/master/install-panel.sh"

INSTALL_ALL=""

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
