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
output "https://github.com/LatamTec/LatamTec/blob/main/install.sh"
output
output "Este script no esta asociado con Minecraft Mojang"


figlet -f standard "Latam Spigot" | lolcat
echo "Instalando Spigot en su Maquina" | lolcat

###########################################################
# LIBRERIA DE SPIGOT #
#
SPIGOT181="https://download.getbukkit.org/spigot/spigot-1.18.1.jar"

SPIGOT171="https://download.getbukkit.org/spigot/spigot-1.17.1.jar"

SPIGOT165="https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar"

SPIGOT152="https://cdn.getbukkit.org/spigot/spigot-1.15.2.jar"

SPIGOT144="https://cdn.getbukkit.org/spigot/spigot-1.14.4.jar"

SPIGOT132="https://cdn.getbukkit.org/spigot/spigot-1.13.2.jar"

SPIGOT122="https://cdn.getbukkit.org/spigot/spigot-1.12.1.jar"

SPIGOT18="https://cdn.getbukkit.org/spigot/spigot-1.8.8-R0.1-SNAPSHOT-latest.jar"

SPIGOT17="https://cdn.getbukkit.org/spigot/spigot-1.7.10-SNAPSHOT-b1657.jar"
#
# LIBRERIA DE SPIGOT #
###########################################################

while [ "$done" == false ]; do
  options=(
    "Instalar Spigot 1.18.1"
    "Instalar Spigot 1.17.1"
    "Instalar Spigot 1.16.5"

    "Instalar Spigot 1.15.2"
    "Instalar Spigot 1.14.4"
    "Instalar Spigot 1.13.2"
    "Instalar Spigot 1.12.2"

    "Instalar Spigot 1.8.8"
    "Instalar Spigot 1.7.10"
  )

  actions=(
    "$SPIGOT181"
    "$SPIGOT171"
    "$SPIGOT165"

    "$SPIGOT152"
    "$SPIGOT144"
    "$SPIGOT132"
    "$SPIGOT122"

    "$SPIGOT18"
    "$SPIGOT17"
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
  [[ " ${valid_input[*]} " =~ ${action} ]] && done=true && IFS=";" read -r i1 i2 <<< "${actions[$action]}" && wget "$i1" "$i2"
done