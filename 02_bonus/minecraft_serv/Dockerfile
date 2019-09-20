FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y software-properties-common openjdk-8-jdk-headless wget

WORKDIR Minecraft_Server

RUN wget https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar

RUN echo "eula=true" > eula.txt

EXPOSE 25565

ENTRYPOINT  java -Xmx1024M -Xms1024M -jar server.jar nogui
