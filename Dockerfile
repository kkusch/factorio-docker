FROM ubuntu:20.04
RUN apt-get update && apt-get dist-upgrade -y
RUN apt install -y xz-utils && apt-get clean

WORKDIR /opt


COPY entrypoint.sh factorio.crt /opt/
RUN mkdir -p /opt/factorio
COPY factorio_headless_x64.tar.xz /tmp/factorio_headless_x64.tar.xz

VOLUME /opt/factorio/saves /opt/factorio/mods

RUN tar -xJf /tmp/factorio_headless_x64.tar.xz && \
    rm /tmp/factorio_headless_x64.tar.xz

EXPOSE 34197/udp
EXPOSE 27015/tcp

CMD ["./entrypoint.sh"]
