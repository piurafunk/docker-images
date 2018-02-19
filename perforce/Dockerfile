FROM    centos:latest

        # Configure the Helix Server package repository
RUN     echo -e "[perforce]\nname=Perforce\nbaseurl=http://package.perforce.com/yum/rhel/7/x86_64/\nenabled=1\ngpgcheck=1" > /etc/yum.repos.d/perforce.repo && \
        # Import the Helix Server package signing key
        rpm --import https://package.perforce.com/perforce.pubkey && \
        # Install the Helix Server binary
        yum install helix-p4d -y && \
	# Move binaries into /usr/bin and /usr/sbin folders
	cp --remove-destination /opt/perforce/bin/p4 /usr/bin/p4 && cp --remove-destination /opt/perforce/sbin/p4d.17.2 /usr/sbin/p4d && \
        # Change ownership of all Perforce related directories to those of the 'perforce' user
        chown perforce:perforce /opt/perforce -R && \
        # Start the server in the background
        p4d -d -r /opt/perforce/servers -p tcp64:[::]:1666 && \
        # Set up default protection rules
        p4 -p localhost:1666 protect -o | p4 -p localhost:1666 protect -i

WORKDIR /opt/perforce
ADD     entrypoint.sh /entrypoint.sh

        # Perforce server binary
CMD     sh /entrypoint.sh
