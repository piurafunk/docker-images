#!/bin/bash
set -x

cleanup() {
        p4 admin stop
        exit 0
}

trap cleanup SIGTERM SIGHUP SIGINT

DAEMON_COMMAND="p4d"
CLIENT_COMMAND="p4"

# Handle the SSL set up
if [ ! -z ${USE_SSL+x} ]; then
	echo "Using SSL..."
	mkdir -p $P4SSLDIR
	chown $(whoami): $P4SSLDIR
	chmod 500 $P4SSLDIR
	DAEMON_COMMAND="$DAEMON_COMMAND -p ssl64:[::]:1666"
	CLIENT_COMMAND="$CLIENT_COMMAND -p ssl:localhost:1666"

	if [ ! -f "$P4SSLDIR/privatekey.txt" ] && [ ! -f "$P4SSLDIR/certificate.txt" ]; then
		p4d -Gc
	fi
fi

$DAEMON_COMMAND -d

# Trust the server fingerprint
if [ ! -z ${USE_SSL+x} ]; then
	$CLIENT_COMMAND trust -y
fi

# Handle initial configuration
if [ ! -f /opt/perforce/configured ]; then
	# Auto-create users or not
	if [ ! -z ${DM_USER_NOAUTOCREATE+x} ]; then
	        $CLIENT_COMMAND configure set dm.user.noautocreate=$DM_USER_NOAUTOCREATE
	fi

	if [ ! -z ${SUPERUSER_USERNAME+x} ] && [ ! -z ${SUPERUSER_PASSWORD+x} ]; then
	        $CLIENT_COMMAND user -o $SUPERUSER_USERNAME | $CLIENT_COMMAND user -if
	        $CLIENT_COMMAND passwd -P $SUPERUSER_PASSWORD $SUPERUSER_USERNAME
	        echo -e "$($CLIENT_COMMAND protect -o)\n\tsuper user $SUPERUSER_USERNAME * //..." | $CLIENT_COMMAND protect -i
	fi

	touch /opt/perforce/configured
fi

$CLIENT_COMMAND admin stop
sleep 1
exec $DAEMON_COMMAND
