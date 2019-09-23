FROM ruby

RUN apt-get update && apt-get upgrade -y && apt-get install -y sqlite nodejs && gem install rails execjs && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn && gem install bundler

EXPOSE 3000

WORKDIR /opt/app
ONBUILD COPY ./ ./
ONBUILD RUN bundle install
ONBUILD RUN if [ "rake db:shema:load >/dev/null" = "-1" ]; then rails db:migrate; fi
ONBUILD RUN rake db:seed

# docker build -t ft-rails:on-build .
# cp /app dir to root of this Dockerfile
# docker build -t fifi ./app
# docker run -dit --name rubhapp -p3000:3000 fifi
