FROM	ubuntu

EXPOSE	443

RUN	apt-get update -y && apt-get install -y git curl build-essential \
libssl-dev zlib1g-dev xxd cron

WORKDIR	/opt

RUN	git clone https://github.com/TelegramMessenger/MTProxy && cd MTProxy && make

WORKDIR	/opt/MTProxy/cfg
RUN	echo "* 12 * * * reboot" >> /etc/crontab && \
echo "* 0 * * * reboot" >> /etc/crontab && \
service cron start

CMD	./gogo.sh


# docker build -t tlgmtprx .
# docker run -d -p443:443 --name tlgprx --restart=always --mount type=bind,src="$(pwd)"/cfg,dst=/opt/MTProxy/cfg tlgmtprx
#
# -e:
# SECRET
# TAG
# SLAVES
# +add other options (optional) to file /cfg/options
# 
# docker exec tlgrx curl localhost:8888/stats
# docker logs mtlg -> to see connection info
