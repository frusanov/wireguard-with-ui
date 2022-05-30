#!/bin/bash

CONFIG="/etc/wireguard/wg0.conf"

watch_config () {
  inotifywait -q -m -e close_write /etc/wireguard/wg0.conf |
  while read -r filename event; do
    echo "Restart wireguard interface"
    wg-quick down wg0
    wg-quick up wg0
  done
}

wait_for_file () {
  while ! test -f $CONFIG; do
    sleep 1
    if test -f $CONFIG; then
      echo "Warch config"
      watch_config
    fi;
  done;
}

wait_for_file;