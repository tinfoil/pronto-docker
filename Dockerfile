FROM alpine:3.6

RUN apk add --no-cache build-base cmake git ruby ruby-dev ruby-json ruby-io-console elixir erlang-crypto nodejs nodejs-npm

RUN gem install --no-document --conservative pronto pronto-rubocop pronto-credo pronto-eslint_npm pronto-stylelint

RUN npm install -g eslint stylelint

RUN mix local.hex --force

RUN mix archive.install --force github rrrene/bunt

RUN mix archive.install --force github rrrene/credo

WORKDIR /data

CMD ["pronto", "run"]
