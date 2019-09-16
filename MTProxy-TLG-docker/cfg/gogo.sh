if [ ! -f proxy-secret ]; then
	curl -s https://core.telegram.org/getProxySecret -o proxy-secret
fi

if [ ! -z "$SECRET" ]; then
	echo $SECRET > secret
	echo "+ Using your secret: $SECRET located in /cfg/secret"
elif [ -f secret ]; then
	SECRET=`cat secret`
	echo "+ Using your secret: $SECRET located in /cfg/secret"
else
	head -c 16 /dev/urandom | xxd -ps > secret
	SECRET=`cat secret`
	echo "+ New secret is generated: $SECRET located in /cfg/secret"
fi

TAG_P=""
if [ ! -z "$TAG" ]; then
	echo $TAG > tag
fi

if [ -f tag ]; then
	TAG=`cat tag`
	if echo "$TAG" | grep -qE '^[0-9a-fA-F]{32}$'; then
		TAG="$(echo "$TAG" | tr '[:upper:]' '[:lower:]')"
		TAG_P="-P $TAG"
		echo $TAG > tag
		echo "+ Tag is ok: $TAG located in /cfg/tag"
	else
		echo "~~~ Invalid TAG format, please edit, but server will try up";
	fi
fi

if [ ! -z "$WORKERS" ]; then
	echo $WORKERS > workers
else
	WORKERS=2
fi

OPTIONS=""
if [ -f options ]; then
	OPTIONS=`cat options`
fi


service cron start >/dev/null

IP=`curl -s -4 "https://digitalresistance.dog/myIp"`
echo "links to connect:"

echo "tg://proxy?server=$IP&port=443&secret=$SECRET
https://t.me/proxy?server=$IP&port=443&secret=$SECRET
"

curl -s https://core.telegram.org/getProxyConfig -o /opt/MTProxy/cfg/proxy-multi.conf

exec /opt/MTProxy/objs/bin/mtproto-proxy -u root -p 8888 --http-stats -H 443 -S $SECRET --aes-pwd proxy-secret proxy-multi.conf -M $WORKERS $TAG_P $OPTIONS > /dev/null
