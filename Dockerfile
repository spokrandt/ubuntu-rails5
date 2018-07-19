FROM ubuntu:latest
ENV BUILD_PACKAGES="ruby-dev" \
    DEV_PACKAGES="libxml2-dev libxslt-dev libyaml-dev libsqlite3-dev mysql-client libmysqlclient-dev libxml2-dev" \
    RUBY_PACKAGES="ruby  ruby-json  nodejs" \
    RAILS_VERSION="5.2.0"
 
RUN \
  apt-get -y update  && \
  apt-get -y install $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
  gem install -N bundler --pre
 
RUN \
  gem install -N pkg-config -v "~> 1.1" && \
  gem install -N nokogiri && \
  gem install -N rails --version "$RAILS_VERSION" && \
  gem install -N public_suffix -v '3.0.2' && \
  gem install -N addressable -v '2.5.2' && \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \

  # cleanup and settings
  bundle config --global build.nokogiri "--use-system-libraries" && \
  bundle config --global build.nokogumbo "--use-system-libraries" && \
  find / -type f -iname \*.apk-new -delete && \
  rm -rf /var/cache/apk/* && \
  rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
  rm -rf ~/.gem \
  mkdir /app

