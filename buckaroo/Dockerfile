FROM    piurafunk/utility-git as watchman-src
RUN     git clone --depth 1 --branch v4.9.0 https://github.com/facebook/watchman.git /watchman

FROM    piurafunk/utility-git as buck-src
RUN     git clone --depth 1 --branch v2019.01.10.01 https://github.com/facebook/buck.git /buck

FROM    piurafunk/utility-git as tbb-src
RUN     git clone --depth 1 --branch tbb_2019 https://github.com/intel/tbb.git /tbb

FROM    ubuntu:18.04 as build

RUN     apt-get update && apt-get install -y \
            software-properties-common && \
        rm -rf /var/lib/apt/lists/*

RUN     add-apt-repository -y ppa:jonathonf/gcc-9.1

## Setup for Watchman
RUN     apt update -y && apt install -y software-properties-common && rm -rf /var/lib/apt/lists/*
RUN     add-apt-repository ppa:jonathonf/gcc-9.1
RUN     apt-get update && apt-get install -y \
            autoconf \
            automake \
            g++-9 \
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
RUN     apt-get update && apt-get install -y \
	        wget && \
	    rm -rf /var/lib/apt/lists/*

## Install Buck
RUN     wget https://github.com/njlr/buck-warp/releases/download/v0.3.0/buck-2019.01.10.01-linux -O /bin/buck && \
        chmod +x /bin/buck

## Setup for Buckaroo
RUN     apt-get update && apt-get install -y \
            git \
            libssl1.0.0 && \
        rm -rf /var/lib/apt/lists/*

## Install Buckaroo
RUN	    wget https://github.com/LoopPerfect/buckaroo/releases/download/v2.2.0/buckaroo-linux -O /bin/buckaroo && \
	    chmod +x /bin/buckaroo

## Install TBB
COPY    --from=tbb-src /tbb /tbb
RUN     cd /tbb && make -j `nproc` tbb tbbmalloc tbbproxy && \
        cp -r /tbb/include/tbb /usr/include && \
        OS=`uname | tr '[:upper:]' '[:lower:]'` && \
        case $(uname -m) in "x86_64") ARCH=intel64 ;; "i686") ARCH=ia32 ;; "ia64") ARCH=ia64 ;; "sparc64") ARCH=sparc ;; "armv7l") ARCH=armv7 ;; *) ARCH=$(uname -m) ;; esac && \
        COMPILER_NAME="gcc_cc`gcc --version | grep ^gcc | sed 's/^.* //g'`" && \
        RUNTIME="libc`ldd --version | grep ^ldd | sed 's/^.* //g'`" && \
        KERNEL="kernel`uname -r | cut -f1 -d"-"`" && \
        cp /tbb/build/${OS}_${ARCH}_${COMPILER_NAME}_${RUNTIME}_${KERNEL}_release/*.so \
            /tbb/build/${OS}_${ARCH}_${COMPILER_NAME}_${RUNTIME}_${KERNEL}_release/*.so.2 \
            /lib/x86_64-linux-gnu && \
        rm -r /tbb

## Add FCGI
RUN apt-get update && apt-get install -y \
        libfcgi-dev && \
    rm -rf /var/lib/apt/lists/*
