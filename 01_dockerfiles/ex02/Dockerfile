FROM ruby

RUN apt-get update && apt-get upgrade -y && apt-get install -y sqlite nodejs && gem install rails execjs && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn && gem install bundler

EXPOSE 3000


WORKDIR /opt/app
ONBUILD COPY ./ ./
ONBUILD RUN ls

ONBUILD RUN bundle install && \
rails db:migrate && rake db:seed 
