# Citra Multiplayer Dedicated Lobby

Quickly stand up new dedicated multiplayer lobbies that will be broadcasted on Citra.

## Usage
```
sudo docker run -d \
  --publish 5000:5000/udp
  citraemu/citra-multiplayer-dedicated \
  --room-name "(COUNTRY) (REGION) - GAME TITLE" \
  --preferred-game "GAME TITLE" \
  --preferred-game-id "TITLE ID" \
  --port 5000 \
  --max_members 4 \
  --username "CITRA ACCOUNT USERNAME" \
  --token "CITRA ACCOUNT TOKEN" \
  --enable-citra-mods \
  --web-api-url https://api.citra-emu.org/
```

Room name should follow the below format.
If multiple servers are stood up, `Server 1`, `Server 2` format should be used.
```
USA East - Pokémon Omega Ruby and Alpha Sapphire - Server 1
USA East - Pokémon Omega Ruby and Alpha Sapphire - Server 2
USA East - Pokémon Sun and Moon - Server 1               
USA East - Pokémon Sun and Moon - Server 2               
USA East - Pokémon Ultra Sun and Ultra Moon - Server 1   
USA East - Pokémon Ultra Sun and Ultra Moon - Server 2   
USA East - Super Smash Bros.                            
USA East - Animal Crossing: New Leaf                     
USA East - Monster Hunter Generations                    
USA East - Monster Hunter XX - Server 1                  
USA East - Monster Hunter XX - Server 2                 
USA East - Zelda: Tri Force Heroes - Server 1            
USA East - Zelda: Tri Force Heroes - Server 2
USA East - Fire Emblem Awakening                     
```
