FROM ruby:2.6.9

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENTRYPOINT ["/usr/local/bin/bundle", "exec", "rackup", "-p", "3000", "-o", "0.0.0.0", "-d"]