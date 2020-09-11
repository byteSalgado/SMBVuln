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

echo -e "$blue Actualizando sistemas y repositorios.."
apt-get update -y && apt-get upgrade -y
clear
echo -e "$blue Repositorios instalados.."

if [ ! -d $directory/exploit ]; then
mkdir $directory/exploit
fi 

#directory verification
directory=$(pwd)   


if which msfconsole >/dev/null; then
sleep 1
echo -e "$blue(Metasploit)$nc ................................................... Instalado [$green✓$nc]"
sleep 0.25
else
sleep 0.25
echo -e "$red(Metasploit)$nc  No instalado [$red✗$nc]"
sleep 1
echo -e "$blue instalando Metasploit en  5$red segundos"
apt-get install curl -y
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
chmod +x msfinstall
./msfinstall
msfdb init
clear
echo -e "$blue Metasploit instalado correctamente.."
sleep 3
fi

if which nmap >/dev/null; then
sleep 1
echo -e "$blue(nmap)$nc ................................................... Instalado [$green✓$nc]"
sleep 0.25
else
sleep 0.25
echo -e "$red(nmap)$nc  No instalado [$red✗$nc]"
sleep 1
echo -e "$blue instalando nmap en  5$red segundos"
apt-get install nmap -y
clear
echo -e "$blue nmap instalado correctamente.."
sleep 3
fi

if which cowsay >/dev/null; then
sleep 1
echo -e "$blue(Cowsay)$nc ................................................... Instalado [$green✓$nc]"
mv /usr/games/cowsay /bin/
sleep 0.25
else
sleep 0.25
echo -e "$red(Cowsay)$nc  No instalado [$red✗$nc]"
sleep 1
echo -e "$blue instalando Cowsay en$red 5$blue segundos.."
sleep 5
apt-get install cowsay -y
mv /usr/games/cowsay /bin/
echo -e "$blue Cowsay instalado correctamente"
sleep 3                      
fi

if which ruby >/dev/null; then
sleep 1

echo -e "$blue(gem)$nc ................................................... Instalado [$green✓$nc]"
sleep 0.25
sleep 1
else
sleep 0.25
echo -e "$red(gem)$nc  No instalado [$red✗$nc]"
sleep 1
echo -e "$blue instalando ruby en$red 5$blue segundos.."
sleep 5
apt-get install ruby -y
gem install lolcat
echo -e "$blue Ruby instalado correctamente.."
sleep 3

fi

if which wine >/dev/null; then
sleep 1
echo -e "$blue(Wine)$nc ................................................... Instalado [$green✓$nc]"
winecfg
sleep 0.25
else
sleep 0.25
echo -e "$red(Wine)$nc  No instalado [$red✗$nc]"
sleep 1
echo -e "$blue instalando wine en$red 5$blue segundos.."
sleep 5
apt-get install wine -y
apt-get install wine32 -y
winecfg
echo -e "$blue Wine instalado correctamente.."
sleep 3
fi
gem install lolcat
clear 
echo -e "$blue Clonando Exploit en 5 segundos.."
sleep 5
git clone https://github.com/gh0stsec/Eternalblue-Doublepulsar-Metasploit/
cp -r Eternalblue-Doublepulsar-Metasploit /root/
cd Eternalblue-Doublepulsar-Metasploit

if [ ! -d root/.msf4/modules/exploits ]; then
mkdir root/.msf4/modules/exploits/
cd /root/.msf4/modules/exploits/
mkdir windows
cd windows
mkdir smb
fi
cd $directory/Eternalblue-Doublepulsar-Metasploit/
cp eternalblue_doublepulsar.rb /root/.msf4/modules/exploits/windows/smb/
echo -e "$blue Actualizando modulos metasploit..."
sleep 3
echo "
reload_all
exit
" > $directory/update.rc
msfconsole -r $directory/update.rc
rm $directory/update.rc
echo -e "$blue Modulos instalados..."
sleep 3
echo -e "$blue Si todo ha salido bien ya tiene disponible el exploit SMB en su Metasploit"
sleep 5
echo -e "$blue Lanzando programa en 5 segundos.."
cd $directory
chmod +x smbvuln.sh
bash smbvuln.sh
