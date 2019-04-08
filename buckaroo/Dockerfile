FROM    piurafunk/utility-git as watchman-src
RUN     git clone --depth 1 --branch v4.9.0 https://github.com/facebook/watchman.git /watchman

FROM    ubuntu:19.04 as build

## Setup for Watchman
RUN     apt-get update && apt-get -y install \
            autoconf \
            automake \
            g++ \
            libssl-dev \
            libtool \
            make \
            pkg-config \
            python2.7-dev \
            python-setuptools \
            sudo && \
	    rm -rf /var/lib/apt/lists/*

## Install Watchman
COPY    --from=watchman-src /watchman /watchman
RUN     cd /watchman && ./autogen.sh && ./configure --enable-lenient && make -j `nproc` && make install && rm -r /watchman

## Setup for Buck
RUN     apt-get update && apt-get -y install \
	        wget && \
	    rm -rf /var/lib/apt/lists/*

## Install Buck
RUN wget https://github.com/njlr/buck-warp/releases/download/v0.3.0/buck-2019.01.10.01-linux -O /bin/buck && \
    chmod +x /bin/buck

## Install Buckaroo
RUN	wget https://github.com/LoopPerfect/buckaroo/releases/download/v2.2.0/buckaroo-linux -O /bin/buckaroo && \
	chmod +x /bin/buckaroo
