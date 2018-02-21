FROM elixir:1.6.1-alpine

RUN apk add --no-cache build-base cmake git ruby ruby-dev ruby-json ruby-io-console nodejs nodejs-npm

RUN gem install --no-document specific_install \
  && gem specific_install --location https://github.com/bsedat/pronto --branch rugged-workaround \
  && gem specific_install --location https://github.com/tinfoil/pronto-credo \
  && gem install --no-document --conservative pronto-rubocop pronto-eslint_npm pronto-stylelint

RUN npm install -g \
  eslint@^4.16.0 \
  eslint-plugin-react \
  postcss-sass \
  stylelint@^8.0.0 \
  stylelint-config-standard \
  stylelint-config-recommended-scss \
  stylelint-scss

RUN mix do local.hex --force, local.rebar --force

RUN mix archive.install --force hex credo 0.9.0-rc2

WORKDIR /data

CMD ["pronto", "run"]
