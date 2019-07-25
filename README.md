# COD4 Docker dedicated server

This is WIP but it works on your local network.  LAN

Runs a Call of duty 4 Modern Warfare dedicated server in a Docker container.

- Based on:
    - [Cod4x](https://cod4x.me/) server program
    - Unzip and curl to download the latest Cod4x
    - Cod4x dependencies: nasm build-essential gcc-multilib g++-multilib
- Compatible with COD4 1.7 clients
- Original COD4 **main** and **zone** files required
- Works with custom mods and usermaps

- This guide is optimized for Unraid but can also be used on Openmediavault

- First make a share on Unraid to place the Call of Duty 4 files in.

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
- The container uses port UDP 28960 as default so that has to be forwarded.

| **Host path** | **Container path** | Note |
| --- | --- | --- |
| /mnt/user/$Sharename$/main | /home/cod4/main | I copied the contents of this from my CoD4:MW |
| /mnt/user/$Sharename$/zone | /home/cod4/zone | I copied the contents of this from my CoD4:MW |
| /mnt/user/$Sharename$/mods | /home/cod4/mods | I keep any mods I want to install on the server in here |
| /mnt/user/$Sharename$/usermaps | /home/cod4/usermaps | I keep my custom maps in here |
| /mnt/user/$Sharename$/serverconf/server.cfg | /home/cod4/main/server.cfg | This is where to point to your server.cfg file |

Important:

The docker uses "EXECFILE", "PORT", "MAP", "MODNAME" and "EXTRA" enviroment variable to pass commands to the servers startup.
It also uses the "READY" enviroment variable just to check if you want to do this. :) If Empty it won't start.
Here is a list of commands that I use:

| ** Variable name ** | **Description** | **Value** |
|---|---|---|
| READY | Checking if you are Ready | YES |
| EXECFILE | The name of the exec file that should be used. Placed in the "main" folder. | server.cfg |
| SERVERTYPE | 2 Is for Internet. 1 Is for LAN. |  1 |
| PORT | Set what port the server should run on | 28960 |
| MAP | Starts the server with the defined rotate sequens in server.cfg file | +map_rotate |
| MODNAME | Defines what mod you whant to use. Write the name of your mod instead of $MODNAME$ | $MODNAME$ |
| EXTRA | 1 only allows players with legal copies to join, 0 allows cracked players, and -1 allows both types of players while the Activison authentication server is down. | +set sv_authorizemode -1 |

## Testing

1. Run a COD4 client and try to connect to `yourhostIPaddress:28960`

OBS: If you use this on OpenMediaValt you have to add the server ip to the favorrites in Call of Duty server list.
