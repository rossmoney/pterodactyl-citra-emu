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

FROM debian:bullseye-slim AS final
LABEL maintainer="citraemu"
RUN apt-get update && apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/
# Create app directory
WORKDIR /usr/src/app
COPY --from=build /root/citra-canary/build/bin/Release/citra-room /usr/src/app

ENTRYPOINT [ "/usr/src/app/citra-room" ]
