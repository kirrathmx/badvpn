#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%50s%s%-20s\n' "BadVPN Setup" ; tput sgr0
if [ -f "/usr/local/bin/badvpn-udpgw" ]
then
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "BadVPN fue instalado con exito."
	echo "Cree una sesion screen"
	echo "Y ejecute el comando:"
	echo ""
	echo "badudp"
	echo ""
	echo "" ; tput sgr0
	exit
else
tput setaf 2 ; tput bold ; echo ""
echo "Este es un script de instalacion de BadVPN"
echo "" ; tput sgr0
read -p "Desea continuar? [s/n]: " -e -i n resposta
if [[ "$resposta" = 's' ]]; then
	echo ""
	echo "Espere..."
	sleep 3
	apt-get update -y
	apt-get install screen wget gcc build-essential g++ make -y
	wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
	tar xvzf cmake*.tar.gz
	cd cmake*
	./bootstrap --prefix=/usr
	make 
	make install
	cd ..
	rm -r cmake*
	mkdir badvpn-build
	cd badvpn-build
	wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/badvpn/badvpn-1.999.128.tar.bz2
	tar xf badvpn-1.999.128.tar.bz2
	cd bad*
	cmake -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
	make install
	cd ..
	rm -r bad*
	cd ..
	rm -r badvpn-build
	echo "#!/bin/bash
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 512 --max-connections-for-client 8" > /bin/badudp
	chmod +x /bin/badudp
	clear
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "BadVPN instalado con exito."
	echo "Para usar creen una sesion screen"
	echo "Y ejecute el comando:"
	echo ""
	echo "badudp"
	echo ""
	echo "" ; tput sgr0
	exit
else 
	echo ""
	exit
fi
fi
