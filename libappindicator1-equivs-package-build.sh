#!/usr/bin/bash
# Autor: Alexandre V.
# Apodo: || ShellDredd || 
# Twitter: @ShellDredd

#Variable de la Validación del estado de las órdenes de sistema.
validation()
{ 
    if [ $? -eq 0 ];
        then 
            echo OK $1 
        else 
            echo Fail $1 
            exit 
        fi 
}

# Órdenes de sistema para la instalaciónde los primeros errores.
sudo apt-get update && sudo apt-get install -y equivs 2>/dev/null && sudo apt --fix-broken install && sudo apt install equivs
validation

#Creación de Dummy con descripción de la librería libappindicator1.

cat << EOF > libappindicator1
Section: misc
Priority: optional
Standards-Version: 3.9.2

Package: libappindicator1
Version: 20211026.0
Description: dummy package of libappindicator1
  .
EOF

#Construcción del paquete deb para su posterior instalación.
equivs-build libappindicator1 && sudo dpkg -i libappindicator1_20211026.0_all.deb && sudo apt-get update
validation

#Instalación de la librería dependiente de libappindicator1.
sudo apt install libc++1 && sudo apt --fix-broken install
validation

echo "--> libappindicator1 and the other resource are installed"