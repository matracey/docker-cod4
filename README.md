# COD4 Docker dedicated server

This is WIP but it works on your local network.  LAN

Runs a Call of duty 4 Modern Warfare dedicated server in a Docker container.

- Based on:
    - [Cod4x](https://cod4x.me/) server program
    - Unzip and curl to download the Cod4x
- Compatible with COD4 1.7 clients
- Original COD4 **main** and **zone** files required
- Works with custom mods and usermaps

- You only need the "main", "zone", "mods" and "usermaps" from your Call of Duty 4.
- You can omit the `main/video` directory as this is not needed by the server.
- You can find a sample file to a "server.cfg" file on github.
~~~
https://github.com/henkall/docker-cod4
~~~

Note the files can be found in the installed game directory. 
~~~
\Activision\Call of Duty 4 - Modern Warfare
~~~

Note the following.
- The container uses by default port UDP 28960 as default so that has to be forwarded.

| **Host path** | **Container path** | Note |
| --- | --- | --- |
| /path/to/COD4/gamefiles | /home/cod4/gamefiles | This is where the main, zone, mods and usermaps folders is going to be|

| **Folders** | **Description** |
| --- | --- |
| main | I copied the contents of this from my CoD4:MW |
| zone | I copied the contents of this from my CoD4:MW |
| mods | I keep any mods I want to use on the server in here |
| usermaps | I keep my custom maps in here |

Important:

The docker uses "EXECFILE", "PORT", "MAP", "MODNAME" and "EXTRA" enviroment variable to pass commands to the servers startup.
It also uses the "READY" enviroment variable just to check if you want to do this. :) If Empty it won't start.
Here is a list of commands that I use:

| ** Variable name ** | **Description** | **Value** |
|---|---|---|
| READY | Checking if you are Ready. Server don't start if this is empty | YES |
| EXECFILE | The name of the config file that should be used. Placed in the "main" folder if you are not using mods. When mods is used you can place the file on the same folder as the mod. | server.cfg |
| SERVERTYPE | 2 Is for Internet. 1 Is for LAN. If 2 is used you have to use: set sv_authtoken "mytokenhere" in the server.cfg file. You can read about it [HERE]. |  1 |
| PORT | Set what port the server should run on. If left empty is defaults to 28960 | 28960 |
| MAP | Starts the server with the defined rotate sequens in server.cfg file. | +map_rotate |
| MODNAME | Defines what mod you whant to use. Write the name of the folder that you mod is in. For example moderpaintball. | $MODNAME$ |
| EXTRA | 1 only allows players with legal copies to join, 0 allows cracked players, and -1 allows both types of players while the Activison authentication server is down. | +set sv_authorizemode -1 |

[HERE]: https://cod4x.me/index.php?/forums/topic/2814-new-requirement-for-cod4-x-servers-to-get-listed-on-masterserver/
## Testing

1. Run a COD4 client and try to connect to `yourhostIPaddress:28960`

OBS: If you use this on OpenMediaValt you have to add the server ip to the favorrites in Call of Duty server list.
