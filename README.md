# Maxi Dispatch 📄 v0.1

**Contact me:**
Maxii#9472



# How to install
---
  - Download and extract the zip.
  - Put the script in the resources carpet from your server.
  - Add into server.cfg:  `ensure maxi_dispatch`
   
  
# Configuration
---

To translate the script just edit the strings from client, index.html and js.

**To add the rob trigger just add this where the rob is started (client-side):**

```
local pedcoords = GetEntityCoords(PlayerPedId())
local id = GetPlayerServerId(PlayerId())
TriggerServerEvent("guille_dispatch:sendRobaAlert", "robo", pedcoords, id) --- Don't Change "robo" becouse is the code for identify the trigger
```

# Preview
---
![preview](https://cdn.discordapp.com/attachments/1057013118162710649/1057758336356986920/image.png)
---
![preview2](https://cdn.discordapp.com/attachments/1057012856442339379/1057764744766947328/image.png)
