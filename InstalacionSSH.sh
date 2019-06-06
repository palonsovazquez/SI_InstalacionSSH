#!/bin/bash
#Ejemplo #2: Script que muestra como asignar valores a variables en forma interactiva por el
#            usuario, uso de la funcion read.
#Author: Gonzalo Silverio  -> gonzasilve@gmail.com
#Archivo: sInstalacionSSh.sh
#pedir el dato al usuario
archivo='/etc/ssh/sshd_config'
puerto=1
clear
echo 'Bienvenido al instalador Automatizado del servicio de red SSH: \n¿Desea instalarlo?(introduzca la contraseña cuando se se pida)[SI/NO].'

read var1
if [ $var1 = "SI" ] ||[ $var1 = "Si" ] || [ $var1 = "S" ] || [ $var1 = "s" ]; then 
    instalado="sudo apt-get install -y openssh-server" 


    if $instalado; then
        clear
        echo "Desea agregar mas opciones de seguridad?, se realizara lo siguiente."  
        echo "1. Se cambiara el puerto por uno que determine el usuario."
        echo "2. Se prohibira el login del usuario root."
        echo "3. Se reducira el tiempo permitido para escribir la contraseña a 30 segundos."
        echo "4. Se reduciran a 3 el numero de intentos de login seguidos."
        echo "5. Se reducira el maximo de conexiones simultaneas a 3."
           
        read var2   
        if [ $var2 = "SI" ] ||[ $var2 = "Si" ] || [ $var2 = "S" ] || [ $var2 = "s" ]; then 

                
            while [ $puerto -lt 1024 ] || [ $puerto -gt 49151 ]; do
              echo "Introduzca el numero de puerto a usar[1024-49151]:"
              read puerto
        
               echo "puerto" 
               if [ $puerto -ge 1024 ] && [ $puerto -le 49151 ]; then   
                   ##sudo echo Port $puerto >> /etc/ssh/sshd_config
                        
                        sudo sed -i 's/#Port 22/Port '$puerto'/g' $archivo
                        sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' $archivo
                        sudo sed -i 's/#LoginGraceTime 2m/LoginGraceTime 30/g' $archivo
                        sudo sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/g' $archivo
                        sudo sed -i 's/#MaxStartups 10:30:100/MaxStartups 3/g' $archivo
                        sudo /etc/init.d/ssh restart
                    else
                        echo "puerto fuera de rango"
                    #clear     
                    echo "Introduzca el numero de puerto a usar. Comprendido entre 1024-49151:"
                    read puerto
               fi
            done
       
            
        fi
     fi

else

 echo Adios... 
fi





echo ---------Fin del script.-------------
