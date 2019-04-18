FROM	ubuntu:18.04 as build

RUN	apt-get update && apt-get install -y \
        libfcgi-dev \
        gdb \
        libc6

CMD gdbserver 0.0.0.0:2000 ./app