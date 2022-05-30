# Wiregiard with Wireguard UI

Image based on [linuxserver/docker-wireguard](https://github.com/linuxserver/docker-wireguard). Look at their documentation at first.

## How to use

Create container with Docker Compose example below. After container creation you need **add manually** `Post Up Script` and `Post Down Script` in server settings in Wireguard UI.

### Post Up Script
```bash
iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth+ -j MASQUERADE
```

### Post Down Script
```bash
iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth+ -j MASQUERADE
```

### Docker compose example

```yaml
version: "2.1"
services:
  wireguard:
    image: frusanov/wireguard-with-ui:latest
    container_name: wireguard
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      # linuxserver/wireguard
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - SERVERURL=wireguard.domain.com #optional
      # wireguard-ui
      - SESSION_SECRET=somerandomvalue # don't forget to change
      - WGUI_USERNAME=admin
      - WGUI_PASSWORD=admin
    volumes:
      - ./config/wireguard:/config
      - ./config/wgui:/wireguard-ui/db
      - /lib/modules:/lib/modules
    ports:
      - 51820:51820/udp
      - 5000:5000/tcp
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
```