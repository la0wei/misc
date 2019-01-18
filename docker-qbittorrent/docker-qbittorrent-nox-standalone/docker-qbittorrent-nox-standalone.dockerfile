FROM ubuntu:18.04  

RUN apt-get update && apt-get upgrade -y \
    ca-certificates \
    curl \
    gpg \
    geoip-database \
    geoip-bin \
  && apt-get install software-properties-common -y \
  && add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y \ 
  && apt-get update && apt-get install qbittorrent-nox -y \
  && apt-get -y autoremove \
  && apt-get -y clean \
  && rm -rf \
  /tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

WORKDIR /config

# ports and volumes
EXPOSE 6881 6881/udp 8080
VOLUME /config /qbdownload

CMD ["qbittorrent-nox"]
