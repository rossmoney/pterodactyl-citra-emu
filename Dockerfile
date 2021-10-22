FROM debian:bullseye AS build
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y full-upgrade && \
    apt-get install -y build-essential libsdl2-dev wget git ccache cmake ninja-build

COPY . /root/build-files

RUN git clone --recursive https://github.com/citra-emu/citra-canary.git /root/citra-canary && \
    cd /root/citra-canary && /root/build-files/.ci/build.sh

FROM debian:bullseye-slim AS final
LABEL maintainer="citraemu"
# Create app directory
WORKDIR /usr/src/app
COPY --from=build /root/citra-canary/build/bin/Release/citra-room /usr/src/app

ENTRYPOINT [ "/usr/src/app/citra-room" ]
