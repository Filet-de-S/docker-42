FROM	ubuntu

EXPOSE	443

RUN	apt-get update -y && apt-get install -y git curl build-essential \
libssl-dev zlib1g-dev xxd cron

WORKDIR	/opt

RUN	git clone https://github.com/TelegramMessenger/MTProxy && cd MTProxy && make

WORKDIR	/opt/MTProxy/cfg
RUN	curl -s https://core.telegram.org/getProxySecret -o proxy-secret
COPY	gogo.sh /opt/MTProxy/cfg
RUN	echo "* 12 * * * reboot" >> /etc/crontab && \
echo "* 0 * * * reboot" >> /etc/crontab && \
service cron start

CMD	./gogo.sh


# docker build -t tlgpr .
# docker run -d -p443:443 --name mtlg --mount src=/cfg,dst=/opt/MTProxy/cfg tlgpr
#
# -e:
# SECRET
# TAG
# WORKERS
#
# -add other options (optional) to file /cfg/options
# -docker logs mtlg -> to see connection info
# -all cfg's will keep while updating a container ;)
