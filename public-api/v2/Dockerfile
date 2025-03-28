ARG ELIXIR_VERSION=1.15.8
ARG OTP_VERSION=26.2.5.3
ARG UBUNTU_VERSION=jammy-20240808

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-ubuntu-${UBUNTU_VERSION}"
ARG RUNNER_IMAGE="ubuntu:${UBUNTU_VERSION}"

FROM ${BUILDER_IMAGE} AS base

ARG BUILD_ENV=prod
ENV MIX_ENV=$BUILD_ENV

ARG APP_NAME
ENV APP_NAME=${APP_NAME}

RUN echo "Build of $APP_NAME for $MIX_ENV environment started"

# install build dependencies
RUN apt-get update -y && apt-get install --no-install-recommends -y build-essential git curl ca-certificates gnupg openssh-client \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

RUN mkdir -p ~/.ssh
RUN touch ~/.ssh/known_hosts
RUN ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

RUN mkdir api
WORKDIR /app/api

# install hex + rebar
RUN mix local.hex --force --if-missing && \
    mix local.rebar --force --if-missing

# install mix dependencies
COPY public-api/v2/mix.exs public-api/v2/mix.lock ./
COPY feature_provider ../../feature_provider
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
RUN mix deps.compile
# copy the rest of the config files
COPY public-api/v2/config/ config/

# Compile the release
COPY public-api/v2/lib lib

FROM base AS dev

COPY public-api/v2/.formatter.exs .formatter.exs
COPY public-api/v2/.credo.exs .credo.exs
COPY public-api/v2/test test

RUN mix compile

CMD [ "/bin/bash",  "-c \"while sleep 1000; do :; done\"" ]

FROM base AS builder

RUN mix release

FROM ${RUNNER_IMAGE} AS runner

# This is needed to connect the GitHub Container Registry package with our repository.
LABEL org.opencontainers.image.source https://github.com/semaphoreio/semaphore

HEALTHCHECK NONE

RUN apt-get update -y && apt-get install --no-install-recommends -y libstdc++6 openssl libncurses5 locales openssh-client \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

ARG APP_NAME
ENV APP_NAME=${APP_NAME}
# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/api/_build/${MIX_ENV}/rel/${APP_NAME} ./

USER nobody

CMD /app/bin/${APP_NAME} start
