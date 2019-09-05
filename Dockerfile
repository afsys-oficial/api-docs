FROM ruby:2.6.4

RUN gem install bundler

COPY Gemfile Gemfile.lock ./

RUN bundle install

WORKDIR /usr/src/app

CMD ["bundle", "exec", "middleman", "server"]
