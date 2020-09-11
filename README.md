# SMBVuln
Attack Protocol SMB windows for execute remote code (MS17-010)

# Informacion:

* el Script automatiza el proceso de explotacion de equipos Windows mediante el protocolo SMB de windows, 
mediante la vulnerabilidad MS17 010 que permite ejecucion remota de codigo de un equipo dentro de la red,
este ataque permite obtener una shell del equipo victima, si este es vulnerable al fallo.
* Este fallo fue corregido por Microsoft en las ultimas versiones de W10 en 2017.
* Este script funciona en arquitecturas amd64 en sistemas debian y deribados.

# Funciones:

* Analizar puerto 445 (SMB) a travez de NMAP
* Comprobar si un equipo es vulnerable a MS17 010
* Explotar el equipo

# Dependencias:

* Metasploit-framework
* Wine
* nmap
* Eternalblue-doblepulsar(exploit)
* Cowsay

# Instalacion:

* git clone https://github.com/byteSalgado/SMBVuln/
* cd SMBVuln/
* chmod +x install.sh
* bash install.sh

# Testeado en:

* Debian 8/9
* Kali Linux
* Parrot

# Creditos:

* Facu Salgado (bytesalgado)
* Regalame una estrella en el repositorio
