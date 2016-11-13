FROM debian:stable-slim
MAINTAINER Jesse B. Crawford <admin@jbcrawford.us>
ENV UNREALIRCD_VERSION 4.0.8

RUN mkdir /data && useradd -r -d /data unrealircd
USER unreal

RUN apt-get update && \
	apt-get install -y build-essential curl libssl-dev ca-certificates libcurl4-openssl-dev zlib1g && \
	apt-get clean

RUN curl -s --location https://www.unrealircd.org/unrealircd4/unrealircd-$UNREALIRCD_VERSION.tar.gz | tar xz && \
	cd unrealircd-$UNREALIRCD_VERSION && \
	./Config \
      --with-showlistmodes \
      --with-listen=5 \
      --with-nick-history=2000 \
      --with-sendq=3000000 \
      --with-bufferpool=18 \
      --with-permissions=0600 \
      --with-fd-setsize=1024 \
      --enable-dynamic-linking && \
    make && \
    make install && \
	cd / && \
	rm -rf unrealircd-$UNREALIRCD_VERSION

RUN apt-get remove -y build-essential && apt-get clean
CMD /data/unrealircd
