FROM alpine:3.6

RUN apk add --no-cache build-base cmake git ruby ruby-dev ruby-json ruby-io-console elixir erlang-crypto nodejs nodejs-npm

RUN gem install --no-document specific_install \
  && gem specific_install --location https://github.com/bsedat/pronto --branch rugged-workaround \
  && gem install --no-document --conservative pronto-rubocop pronto-credo pronto-eslint_npm pronto-stylelint

RUN npm install -g eslint stylelint stylelint-config-standard

RUN mix do local.hex --force, local.rebar --force

# Tools for building (erlang) dependencies
RUN apk add --no-cache erlang-syntax-tools erlang-parsetools

RUN mix archive.install --force github rrrene/bunt

RUN mix archive.install --force github rrrene/credo

WORKDIR /data

CMD ["pronto", "run"]
