FROM	alpine:3.9.2 as build

RUN	apk add --no-cache \
        entr \
        fcgi-dev \
        gdb \
        libc6-compat \
        the_silver_searcher

CMD gdbserver 0.0.0.0:2000 ./app