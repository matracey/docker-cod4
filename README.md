# COD4 Docker dedicated server

Runs a Call of duty 4 Modern Warfare dedicated server in a Docker container.

- Based on:
    - [Cod4x](https://cod4x.me/) server program
    - Unzip and curl to download the latest Cod4x
    - Cod4x dependencies: nasm build-essential gcc-multilib g++-multilib
- Compatible with COD4 1.7 clients
- Original COD4 **main** and **zone** files required
- Works with custom mods and usermaps

- If you wan't to run this manually then here is a example how to do it:

~~~
docker run --user=root -it --name cod4 \
-p 28960:28960 -p 28960:28960/udp \
-v /cod4/user/$Sharename$/res/main:/home/cod4/main \
-v /cod4/user/$Sharename$/res/zone:/home/cod4/zone \
-v /cod4/user/$Sharename$/res/mods:/home/cod4/mods \
-v /cod4/user/$Sharename$/res/usermaps:/home/cod4/usermaps \
-v /cod4/user/$Sharename$/server.cfg:/home/cod4/main/server.cfg \
-v /cod4/user/$Sharename$/games_mp.log:/home/cod4/main/games_mp.log \
henkallsn/docker-cod4 +set sv_authorizemode '-1' +exec server.cfg +map_rotate
~~~

- This guide is optimized for Unraid

- First make a share on Unraid to place the Call of Duty 4 files in.

- You only need the "main", "zone", "mods" and "usermaps" from your Call of Duty 4.
- You can omit the `main/video` directory as this is not needed by the server.
- You can find a sample file to a "server.cfg" file on github.
	~~~
	https://github.com/henkall/docker-cod4
	~~~

Note the files can be found in the installed game directory. 
	```bash
	~\Activision\Call of Duty 4 - Modern Warfare
	```

Note the following.
- The container port UDP 28960 is forwarded to the host port UDP 28960
- The container port UDP 20810 is forwarded to the host port UDP 20810
- The container port UDP 20800 is forwarded to the host port UDP 20800

| **Host path** | **Container path** | Note |
| --- | --- | --- |
| /mnt/user/$Sharename$/main | /home/cod4/main ||
| /mnt/user/$Sharename$/zone | /home/cod4/zone ||
| /mnt/user/$Sharename$/mods | /home/cod4/mods ||
| /mnt/user/$Sharename$/usermaps | /home/cod4/usermaps | This folder might not be in your Call of Duty 4 |


Important:

In Unraid the is a "Post Arguments" field under the "Advanced View"
Push the slider in the upper right corner of Unraid. (Basic View)

In the "Post Arguments" put in this:

	```bash
	+set sv_authorizemode '-1' +exec server.cfg +map_rotate 
	```

## Testing

1. Run a COD4 client and try to connect to `yourhostIPaddress:28960`
