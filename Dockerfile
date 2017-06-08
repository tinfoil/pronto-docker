FROM ruby:2.4.1-alpine

RUN apk add --no-cache build-base cmake

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/

RUN bundle install --deployment

ENV BUNDLE_GEMFILE $APP_HOME/Gemfile

WORKDIR /data

CMD ["bundle", "exec", "pronto", "run"]
