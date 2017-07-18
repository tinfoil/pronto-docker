FROM alpine:3.6

RUN apk add --no-cache build-base cmake git ruby ruby-dev ruby-json ruby-io-console elixir erlang-crypto nodejs nodejs-npm

RUN gem install --no-document specific_install \
  && gem specific_install --location https://github.com/bsedat/pronto --branch rugged-workaround \
  && gem install --no-document --conservative pronto-rubocop pronto-credo pronto-eslint_npm pronto-stylelint

RUN npm install -g eslint@4.2.0 stylelint@8.0.0 stylelint-config-standard

RUN mix do local.hex --force, local.rebar --force

# Tools for building (erlang) dependencies
RUN apk add --no-cache erlang-syntax-tools erlang-parsetools

RUN mix archive.install --force hex bunt 0.2.0
RUN mix archive.install --force hex credo 0.8.4

WORKDIR /data

CMD ["pronto", "run"]
