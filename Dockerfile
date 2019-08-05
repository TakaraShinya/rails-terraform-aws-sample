FROM ruby:2.6.3
ENV LANG C.UTF-8
ENV APP_ROOT /usr/src/app
RUN apt-get update -qq && \
    apt-get install -y vim nodejs \
                       mariadb-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*
WORKDIR $APP_ROOT
COPY Gemfile Gemfile.lock $APP_ROOT/
RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem
COPY . $APP_ROOT
CMD ["rails", "server", "-b", "0.0.0.0"]
