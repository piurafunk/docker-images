FROM    piurafunk/utility-git as buck-src
RUN     git clone --depth 1 https://github.com/facebook/buck.git /buck

FROM    piurafunk/utility-git as watchman-src
RUN     git clone --depth 1 --branch v4.9.0 https://github.com/facebook/watchman.git /watchman

FROM    piurafunk/utility-git as buckaroo-src
RUN     git clone --depth 1 https://github.com/LoopPerfect/buckaroo.git /buckaroo

FROM    piurafunk/utility-git as cppcms-src
RUN     git clone --depth 1 https://github.com/artyom-beilis/cppcms.git /cppcms

FROM    openjdk:8 as build

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
            sudo

## Install Watchman
COPY    --from=watchman-src /watchman /watchman
RUN     cd /watchman && ./autogen.sh && ./configure && make && make install

## Setup for Buck
RUN     apt-get update && apt-get -y install \
            ant \
            python2.7

## Install Buck
COPY    --from=buck-src /buck /buck
RUN     cd /buck && ant && ./bin/buck build --show-output buck
ENV     PATH="$PATH:/buck/bin"

## Setup for Buckaroo
RUN     apt-get update && apt-get -y install \
            cmake \
            zip

## Install Buckaroo
COPY    --from=buckaroo-src /buckaroo /buckaroo
RUN     cd /buckaroo && buck build :buckaroo-cli

## Create bash wrapper for buckaroo .jar
RUN     echo -e "#!/bin/bash\njava -jar \"/buckaroo/buck-out/gen/buckaroo-cli.jar\" \$@" > /bin/buckaroo && chmod +x /bin/buckaroo

## Setup for CppCms
RUN     apt-get update && apt-get -y install \
            libgcrypt11-dev \
            libicu-dev \
            libpcre3-dev \
            zlib1g-dev
