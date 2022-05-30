#!/bin/bash

WGUI_VERSION=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/ngoduykhanh/wireguard-ui/releases/latest))

curl -LJO https://github.com/ngoduykhanh/wireguard-ui/releases/download/$WGUI_VERSION/wireguard-ui-$WGUI_VERSION-linux-$PLATFORM.tar.gz

tar -xvf wireguard-ui-$WGUI_VERSION-linux-$PLATFORM.tar.gz -C /wireguard-ui \
  && rm wireguard-ui-$WGUI_VERSION-linux-$PLATFORM.tar.gz