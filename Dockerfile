FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
RUN chmod +x /usr/local/bin/ecs-cli

RUN mkdir /pierpontglobal-logistic-api
WORKDIR /pierpontglobal-logistic-api

COPY Gemfile /pierpontglobal-logistic-api/Gemfile

COPY . /pierpontglobal-logistic-api

RUN gem install bundler
RUN bundle check || bundle install

CMD bundle exec rails server -b 0.0.0.0