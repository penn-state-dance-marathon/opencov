FROM elixir:1.12-alpine

RUN apk add --update-cache build-base git postgresql-client nodejs yarn

WORKDIR /opencov

ENV MIX_ENV prod

RUN mix local.hex --force && mix local.rebar --force

COPY package.json ./
RUN yarn install

COPY mix.exs ./
RUN mix deps.get || cat erl_crash.dump

COPY . .

RUN mix compile
RUN mix assets.compile

CMD ["mix", "phx.server"]
