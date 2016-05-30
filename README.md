# Docker-cod4

This repository contains a Docker container for hosting a dedicated server for Call of Duty 4: Modern Warfare with CoD4x server mod. It is based on [hberntsen/docker-cod4](https://github.com/hberntsen/docker-cod4) with a number of enhancements.

## Installation

1. Clone this repository.
2. Build the Docker image, e.g. `docker build -t matracey/modern-warfare`.
3. Copy the resource files from the `main/` and `zone/` directories to a directory of your choice on your Docker host.
   - You can omit the `main/video` directory as this is not needed by the server.
   - For example, use `/var/cod4/res`, and within it have `main`, `zone`, `usermaps`, and `mods`.
4. Run your server! See the example command below.
5. Connect to your server!

## Example Run Command

```bash
docker run --user=root -it --name mw \
-p 28960:28960 -p 28960:28960/udp \
-v /var/cod4/res/main:/home/cod4/main \
-v /var/cod4/res/zone:/home/cod4/zone \
-v /var/cod4/res/mods:/home/cod4/mods \
-v /var/cod4/res/usermaps:/home/cod4/usermaps \
-v /var/cod4/server.cfg:/home/cod4/main/server.cfg \
-v /var/cod4/games_mp.log:/home/cod4/main/games_mp.log \
matracey/modern-warfare +set sv_authorizemode '-1' +exec server.cfg +map_rotate
```

## Notes on Building Your Run Command

- `-it`: Runs the Docker container in interactive, pseudo-tty mode. Required for typing into the CoD console.
  - Alternatively, use `-dit` to start the container detached. Attach later with `docker attach <container>`.
  - To restart a stopped container, use `docker start -ai <container>`. This automatically and interactively attaches to the container on start.
- `-p 28960:28960 -p 28960:28960/udp`: Forwards TCP & UDP ports 28960 (the default CoD Server Port) to the Docker host. Other ports may not be necessary.

## Volume Mounts Explained

- `/var/cod4/res/main:/home/cod4/main`: Mounts the `main` folder in the Docker host's filesystem to the container's filesystem. Contents are copied from the CoD4:MW installation on a PC.
- `/var/cod4/res/zone:/home/cod4/zone`: Mounts the `zone` folder in the Docker host's filesystem to the container's filesystem. Contents are copied from the CoD4:MW installation on a PC.
- `/var/cod4/res/mods:/home/cod4/mods`: Mounts the `mods` folder in the Docker host's filesystem to the container's filesystem. Place mods for the server here.
- `/var/cod4/res/usermaps:/home/cod4/usermaps`: Mounts the `usermaps` folder in the Docker host's filesystem to the container's filesystem. Place custom maps here.
- `-v /var/cod4/server.cfg:/home/cod4/main/server.cfg`: Mounts the `server.cfg` file within the `main` folder within the container's filesystem.
  - __*NB*__: This file __needs__ to exist on your host machine before you run the server or Docker will create this as a directory.
- `-v /var/cod4/games_mp.log:/home/cod4/main/games_mp.log`: Mounts the `games_mp.log` file within the `main` folder within the container's filesystem. Log file for the server.
  - __*NB*__: This file __needs__ to exist on your host machine before you run the server or Docker will create this as a directory.
- `matracey/modern-warfare +set sv_authorizemode '-1' +exec server.cfg +map_rotate`: You can pass custom arguments to the server here. These are the args that are passed by default.

A sample `server.cfg` file is included in this repository. It is not part of the build, but it can help you create your own configuration.
