FROM ubuntu:18.04  

RUN apt update && apt upgrade -y --no-install-recommends install \
    ca-certificates \
    curl \
    gpg \
    geoip-database \
    geoip-bin \
  && apt install software-properties-common - qy  \
  && add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -qy \ 
  && apt update && apt install qbittorrent-nox -qy \
  && apt -y autoremove \
  && apt -y clean \
  &&  rm -rf \
  /tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

##gosu
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.11/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh
 
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
WORKDIR /config

# ports and volumes
EXPOSE 6881 6881/udp 8080
VOLUME /config /qbdownload

CMD ["qbittorrent-nox"]