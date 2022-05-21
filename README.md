# Wiregiard with Wireguard UI

Image based on [linuxserver/docker-wireguard](https://github.com/linuxserver/docker-wireguard). Look at their documentation at first.

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