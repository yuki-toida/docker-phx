FROM elixir
MAINTAINER yuki-toida

ADD . /code
WORKDIR /code

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    inotify-tools \
    mysql-client \
    nodejs \
    npm && \
    npm cache clean && \
    npm install n -g && \
    n stable && \
    ln -sf /usr/local/bin/node /usr/bin/node && \
    apt-get purge -y nodejs npm && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

CMD ["sh", "-c", "mix deps.get && mix phx.server"]
