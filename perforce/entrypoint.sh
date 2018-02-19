#!/bin/bash

cleanup() {
        p4 admin stop
        exit 0
}

trap cleanup SIGTERM SIGHUP SIGINT

p4d -d

if [ ! -f /opt/perforce/configured ]; then
	# Auto-create users or not
	if [ ! -z ${DM_USER_NOAUTOCREATE+x} ]; then
	        p4 configure set dm.user.noautocreate=$DM_USER_NOAUTOCREATE
	fi

	if [ ! -z ${SUPERUSER_USERNAME+x} ] && [ ! -z ${SUPERUSER_PASSWORD+x} ]; then
	        p4 user -o $SUPERUSER_USERNAME | p4 user -if
	        p4 passwd -P $SUPERUSER_PASSWORD $SUPERUSER_USERNAME
	        echo -e "$(p4 protect -o)\n\tsuper user $SUPERUSER_USERNAME * //..." | p4 protect -i
	fi

	touch /opt/perforce/configured
fi

tail -f /dev/null &
wait
