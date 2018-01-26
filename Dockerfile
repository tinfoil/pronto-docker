FROM elixir:1.6.0-alpine

RUN apk add --no-cache build-base cmake git ruby ruby-dev ruby-json ruby-io-console nodejs nodejs-npm

RUN gem install --no-document --conservative pronto pronto-rubocop pronto-eslint_npm pronto-stylelint pronto-credo

RUN npm install -g \
  eslint@^4.16.0 \
  eslint-plugin-react \
  postcss-sass \
  stylelint@^8.0.0 \
  stylelint-config-standard \
  stylelint-config-recommended-scss \
  stylelint-scss

RUN mix do local.hex --force, local.rebar --force

# Tools for building (erlang) dependencies
RUN apk add --no-cache erlang-syntax-tools erlang-parsetools

RUN mix archive.install --force hex bunt 0.2.0
RUN mix archive.install --force hex credo 0.8.4

WORKDIR /data

CMD ["pronto", "run"]
