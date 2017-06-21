#!/bin/ash

FILE_NAME="regrowth.zip"

if ! stat ServerStart.sh > /dev/null 2>&1 ; then
	wget --no-check-certificate -O /srv/minecraft/$FILE_NAME https://ftb.cursecdn.com/FTB2/modpacks/Regrowth/1_0_2/RegrowthServer.zip
	unzip -n /srv/minecraft/$FILE_NAME -d /srv/minecraft
	rm /srv/minecraft/$FILE_NAME
	rm /srv/minecraft/eula.txt -f
	echo eula=true > /srv/minecraft/eula.txt
fi
exec sh ServerStart.sh
