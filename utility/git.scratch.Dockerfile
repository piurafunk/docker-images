FROM alpine:3.10.2 as build

RUN apk add --no-cache asciidoc autoconf docbook2x gcc gettext libc-dev make zlib-dev

WORKDIR /tmp/git

ENV VERSION=2.23.0

RUN wget https://codeload.github.com/git/git/tar.gz/v$VERSION -O v$VERSION.tar.gz

RUN tar -xzf v$VERSION.tar.gz

RUN cd git-$VERSION

RUN make configure && ./configure --prefix=/tmp/git/build && make -j `nproc` all doc info && make -j `nproc` install install-doc install-html install-info