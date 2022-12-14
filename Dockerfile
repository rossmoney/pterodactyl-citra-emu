# syntax=docker/dockerfile:1.3
FROM debian:bullseye AS build
ENV DEBIAN_FRONTEND=noninteractive
ARG USE_CCACHE
RUN apt-get update && apt-get -y full-upgrade && \
    apt-get install -y build-essential wget git ccache cmake ninja-build libssl-dev

COPY . /root/build-files

RUN --mount=type=cache,id=ccache,target=/root/.ccache \
    git clone --depth 1000 --recursive https://github.com/citra-emu/citra-canary.git /root/citra-canary && \
    cd /root/citra-canary && /root/build-files/.ci/build.sh

FROM debian:bullseye AS final
# Create app directory

USER container
ENV  USER container
ENV HOME /home/container

WORKDIR /usr/src/app

COPY --from=build /root/citra-canary/build/bin/Release/citra-room /usr/src/app

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
