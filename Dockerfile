FROM lscr.io/linuxserver/wireguard:latest

ENV PLATFORM=amd64
ENV WGUI_SERVER_POST_UP_SCRIPT="iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth+ -j MASQUERADE"
ENV WGUI_SERVER_POST_DOWN_SCRIPT="iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth+ -j MASQUERADE"

WORKDIR /wireguard-ui

RUN apt-get update && \
    apt install -y --no-install-recommends \
      inotify-tools

COPY ./utils/* /utils/
COPY ./entrypoint.sh /

RUN chmod +x /utils/watch-changes.sh && \
    chmod +x /utils/install-wgui.sh && \
    /utils/install-wgui.sh

EXPOSE 5000/tcp

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]



