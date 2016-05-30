# docker-cod4
Call of Duty 4: Modern Warfare dedicated server. Uses CoD4x server mod. Based off hberntsen/docker-cod4 with a number of enhancements.

1. Clone this repository.
2. Build the docker image, e.g. `docker build -t matracey/modern-warfare`
3. Copy the resource files from the `main/` and `zone/` directories to a directory of your choice on your Docker host.
    * You can omit the `main/video` directory as this is not needed by the server. 
    * I use `/var/cod4/res`, and within there I have `main`, `zone`, `usermaps` and `mods`.
4. Run your server!
    * I use this command to start my server:
~~~
docker run --user=root -it --name mw \
-p 28960:28960 -p 28960:28960/udp \
-v /var/cod4/res/main:/home/cod4/main \
-v /var/cod4/res/zone:/home/cod4/zone \
-v /var/cod4/res/mods:/home/cod4/mods \
-v /var/cod4/res/usermaps:/home/cod4/usermaps \
-v /var/cod4/server.cfg:/home/cod4/main/server.cfg \
-v /var/cod4/games_mp.log:/home/cod4/main/games_mp.log \
matracey/world-at-war +set sv_authorizemode '-1' +exec server.cfg +map_rotate
~~~
5. Connect to your server!

## Notes on building your run command
* `-it`: This runs the docker container in interactive, pseudo-tty mode. You'll need this to be able to type into the CoD console.
    * You could also use `-dit` here instead, which would start the container detached. You can attach later by running `docker attach <container>`.
    * To restart a stopped container, use the command `docker start -ai <container>`. This will automatically and interactively attach to the container on start.

* `-p 28960:28960 -p 28960:28960/udp`: This forwards TCP & UDP ports 28960 (the default CoD Server Port) to the docker host. I haven't needed any other ports exposed but YMMV.

* `-v /var/cod4/res/main:/home/cod4/main`: Mounts the `main` folder in my Docker host's filesystem to the `main` folder within the container's filesystem. I copied the contents of this from the CoD4:MW installation on my PC.

* `-v /var/cod4/res/main:/home/cod4/zone`: Mounts the `zone` folder in my Docker host's filesystem to the `zone` folder within the container's filesystem. I copied the contents of this from the CoD4:MW installation on my PC.

* `-v /var/cod4/res/mods:/home/cod4/mods`: Mounts the `mods` folder in my Docker host's filesystem to the `mods` folder within the container's filesystem. I keep any mods I want to install on the server in here.

* `-v /var/cod4/res/usermaps:/home/cod4/usermaps`: Mounts the `usermaps` folder in my Docker host's filesystem to the `usermaps` folder within the container's filesystem. I keep my custom maps in here.

* `-v /var/cod4/server.cfg:/home/cod4/main/server.cfg`: Mounts the `server.cfg` file within the `main` folder within the container's filesystem. 
    * __*NB*:__ This file **needs** to exist on your host machine before you run the server or Docker will create this as a directory. 

* `-v /var/cod4/games_mp.log:/home/cod4/main/games_mp.log`: Mounts the `games_mp.log` file within the `main` folder within the container's filesystem. Log file for the server. 
    * __*NB*:__ This file **needs** to exist on your host machine before you run the server or Docker will create this as a directory.

* `matracey/world-at-war +set sv_authorizemode '-1' +exec server.cfg +map_rotate`: You can pass custom arguments to the server here. These are the args that are passed by default.

I've also included a sample `server.cfg` file in this repository. It's not part of the build, but it should help you to build out your own config. 