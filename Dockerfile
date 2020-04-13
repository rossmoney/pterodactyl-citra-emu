FROM citraemu/build-environments:linux-fresh

# Create app directory
WORKDIR /usr/src/app

# Download the Citra binary.
# Bundle citra-room inside the image and delete the downloaded tar file.
RUN wget -O citra-linux.tar.xz https://github.com/citra-emu/citra-canary/releases/download/canary-1641/citra-linux-20200413-e9f68ae.tar.xz && \
    tar --wildcards --strip=1 -xJf citra-linux.tar.xz */citra-room && rm citra-linux.tar.xz

ENTRYPOINT [ "/usr/src/app/citra-room" ]
