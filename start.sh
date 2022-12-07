#!/bin/ash

/home/container/citra-room --room-name "<INSERT ROOM NAME HERE>" \
  --room-description "<INSERT ROOM NAME HERE>" \
  --preferred-game "<INSERT GAME TITLE HERE>" \
  --preferred-game-id "<INSERT TITLE ID HERE>" \
  --port 5000 \
  --max_members 4 \
  --token "<INSERT CITRA ACCOUNT TOKEN HERE>" \
  --enable-citra-mods \
  --web-api-url https://api.citra-emu.org/
