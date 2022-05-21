FROM lscr.io/linuxserver/wireguard:latest

WORKDIR /wireguard-ui

ENV PLATFORM=amd64
ENV WGUI_VERSION=0.3.7

RUN curl -LJO https://github.com/ngoduykhanh/wireguard-ui/releases/download/v$WGUI_VERSION/wireguard-ui-v$WGUI_VERSION-linux-$PLATFORM.tar.gz

RUN tar -xvf wireguard-ui-v$WGUI_VERSION-linux-$PLATFORM.tar.gz \
  && rm wireguard-ui-v$WGUI_VERSION-linux-$PLATFORM.tar.gz

EXPOSE 5000/tcp

COPY ./entrypoint.sh /
ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]



