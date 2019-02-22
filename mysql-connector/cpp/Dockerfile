FROM	piurafunk/git as mysql-connector-cpp-source
RUN	git clone https://github.com/mysql/mysql-connector-cpp.git /src && \
	cd /src && git checkout 8.0

FROM	piurafunk/git as openssl-source
RUN	git clone https://github.com/openssl/openssl.git /src

FROM	alpine:3.9

COPY	--from=mysql-connector-cpp-source /src /src
COPY	--from=openssl-source /src /open-ssl-src

RUN	apk add --no-cache \
		cmake \
		g++ \
		linux-headers \
		make \
		openssl-dev \
		perl

WORKDIR /open-ssl-src
RUN	./config --prefix=/open-ssl-build --openssldir=/open-ssl-build
RUN	make
RUN	make test
RUN	make install

RUN	mkdir /build
WORKDIR	/build

RUN	cmake -Wno-dev -DWITH_SSL=system -DBUILD_STATIC=true -DCMAKE_INSTALL_PREFIX=/mysql-connector-cpp-build /src
RUN	cmake --build .
RUN	cmake --build . --target install
ENV	LIBRARY_PATH=$LIBRARY_PATH:/mysql-connector-cpp-build/lib64/debug

RUN	mkdir /build-test
WORKDIR /build-test

RUN	cmake -DWITH_CONCPP=/mysql-connector-cpp-build -DBUILD_STATIC=true /src/testapp
RUN	cmake --build .

