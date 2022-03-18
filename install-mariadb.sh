#!/bin/bash


#
#  Latamtec Instalador @ KalixCloud
#
# Instalador de complementos para Servidores
# de minecraft en VPS UBUNTU | 18.04 20.04 |
#
#     Pagina Web: https://theboykiss.ovh
#

install_options(){
    echo -e "\E[44;1;37m    INSTALADOR MYSQL | By TheBoykissOld     \E[0m" 
    echo ""
    echo -e "[1] Instalar MYSQL."
    echo -e "[2] Restablecer Contraseña MYSQL."
    read -r choice
    case $choice in
        1 ) installoption=1
            echo -e "\n\033[1;36mINICIANDO INSTALACION \033[1;33mESPERE..."
            echo ""
            ;;
        2 ) installoption=2
            echo -e "\n\033[1;36mRESTABLECIENDO CONTRASEÑA MYSQL ROOT \033[1;33mESPERE..."
            echo ""
            ;;
        * ) echo -e "\n\033[1;36mCOMANDO DESCONOCIDO"
            echo ""
            install_options
    esac
}

database(){
  sudo apt update
  sudo apt install mariadb-server
  sudo mysql_secure_installation
  echo -e "Instalacion de MySQL y establecimiento de la contraseña de root..."
  password=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 48 | head -n 1`
  Q0="SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$password');"
  Q1="FLUSH PRIVILEGES;"
  SQL="${Q0}${Q1}"
}
database_brodcast() {
  SERVER_IP=$(dig +short myip.opendns.com @resolver1.opendns.com -4)
  echo -e "------------------------------------------------------------------"
  echo -e "DATOS MYSQL // INSTALADOR By THEBOYKISSOLD"
  echo -e ""
  echo -e "Host: $SERVER_IP"
  echo -e "Puerto: 3306"
  echo -e "Usuario: root"
  echo -e "Contraseña: $password"
  echo -e "------------------------------------------------------------------"
}

mariadb_root_reset(){
    rootpassword=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 48 | head -n 1`  
    Q0="SET old_passwords=0;"
    Q1="SET PASSWORD FOR root@localhost = PASSWORD('$rootpassword');"
    Q2="FLUSH PRIVILEGES;"
    SQL="${Q0}${Q1}${Q2}"
    mysql mysql -e "$SQL"
    echo -e "Tu nueva contraseña es: ( $rootpassword )"
}

#Comandos
install_options
case $installoption in 
    1)  database
        database_brodcast
        ;;
    2)  mariadb_root_reset
        ;;
esac
