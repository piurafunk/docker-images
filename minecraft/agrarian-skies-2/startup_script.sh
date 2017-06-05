#!/bin/ash

if ! stat forge-1.7.10-10.13.4.1492-1.7.10-universal.jar > /dev/null 2>&1 ; then
	wget --no-check-certificate -O /srv/minecraft/as2.zip https://addons-origin.cursecdn.com/files/2261/980/AS2-1.1.14-Server.zip
	if [ "$(ls -A world)" ]; then
		unzip -n /srv/minecraft/as2.zip -x backups/* -x world/* -d /srv/minecraft
	else
		unzip -n /srv/minecraft/as2.zip -x backups/* -d /srv/minecraft
	fi
	rm /srv/minecraft/as2.zip
fi
echo eula=true > /srv/minecraft/eula.txt
exec java -Dfml.queryResult=confirm -jar forge-1.7.10-10.13.4.1492-1.7.10-universal.jar
