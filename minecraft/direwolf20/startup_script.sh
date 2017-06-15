#!/bin/ash

if ! stat FTBInstall.sh > /dev/null 2>&1 ; then
	wget --no-check-certificate -O /srv/minecraft/dw20.zip https://addons-origin.cursecdn.com/files/2272/696/FTBDirewolf20Server-1.10.0-1.7.10.zip
	unzip -n /srv/minecraft/dw20.zip -x world/* -d /srv/minecraft
	rm /srv/minecraft/dw20.zip
	rm /srv/minecraft/eula.txt -f
	echo eula=true > /srv/minecraft/eula.txt
fi
exec sh ServerStart.sh
