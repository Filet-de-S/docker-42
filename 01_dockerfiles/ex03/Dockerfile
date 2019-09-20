FROM ubuntu:16.04

RUN apt-get update -y && apt-get upgrade -y && \
apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
apt-get update -y && apt-get install -y nodejs && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update -y && apt-get install -y yarn

RUN apt-get install -y software-properties-common
RUN apt-get install -y python-software-properties && \
add-apt-repository ppa:longsleep/golang-backports

ENV GDK_GO_VERSION="1.12"
ENV PATH="/usr/lib/go-${GDK_GO_VERSION}/bin:$PATH"

RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y \
git postgresql postgresql-contrib libpq-dev redis-server \
libicu-dev cmake g++ libre2-dev libkrb5-dev libsqlite3-dev golang-${GDK_GO_VERSION}-go ed \
pkg-config graphicsmagick runit libimage-exiftool-perl rsync build-essential libreadline-dev \
openssh-server nginx

###

RUN useradd -m -d /home/gitlab-devCE git
USER git
WORKDIR /home/gitlab-devCE

RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src
ENV PATH="/home/gitlab-devCE/.rbenv/shims:/home/gitlab-devCE/.rbenv/bin:$PATH"
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN mkdir -p "$(rbenv root)"/plugins && \
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

RUN rbenv install 2.6.3
RUN rbenv global 2.6.3 

RUN gem install bundler && gem install gitlab-development-kit && \
gdk init

WORKDIR gitlab-development-kit
RUN gdk install shallow_clone=true

RUN echo 3000 > port && echo 0.0.0.0 > host && \
echo true > https_enabled && \
sed -i "s/#sshd/sshd/g" Procfile && \
sed -i "s/#nginx/nginx/g" Procfile && \
sed "s/https = false/https = true/g" gitlab/config/gitlab.yml && \
gdk reconfigure

RUN sed -i "s/127.0.0.1:2222/0.0.0.0:2222/g" openssh/sshd_config && \
sed -i "s/127.0.0.1:3443/0.0.0.0:3443/g" nginx/conf/nginx.conf && \
sed "s/https = false/https = true/g" gitlab/config/gitlab.yml

EXPOSE 3443 2222

CMD gdk run

# VBoxManage modifyvm default --memory 4096 --cpus 2
# docker build -t gl_dev-ce .
# docker run --name glab -p3000:3000 -p3443:3443 -p2222:2222 -p3808:3808 gl_dev-ce

# ssh-keygen -t ed25519 -C "asd@asd.com"

# root and 5iveL!fe
