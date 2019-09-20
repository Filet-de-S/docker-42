FROM debian

WORKDIR /media

RUN apt-get update && apt-get install -y wget bzip2 && \
rm -rf /var/lib/apt/lists/* && \
wget -O ts https://files.teamspeak-services.com/releases/server/3.9.1/teamspeak3-server_linux_amd64-3.9.1.tar.bz2 && \
tar xfj ts && rm -rf ts && apt-get --purge autoremove -y wget bzip2

WORKDIR teamspeak3-server_linux_amd64

EXPOSE 9987/udp 30033 10011 

ENV TS3SERVER_LICENSE=accept

ENTRYPOINT ./ts3server
