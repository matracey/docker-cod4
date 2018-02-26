FROM centos:7
MAINTAINER matracey

ENV LANG=da_DK.UTF-8
ENV LANGUAGE=da_DK

# Running options to COD4 server 
ENV PORT="28960"
ENV MODNAME=""
ENV MAP="+map_rotate"
ENV EXTRA="+set sv_authorizemode -1"

#from http://cod4-linux-server.webs.com/
RUN yum -y install glibc.i686 libgcc.i686 libstdc++.i686 zlib.i686

RUN useradd cod4
ADD cod4 /home/cod4/
RUN chown -R cod4:cod4 /home/cod4

USER cod4
WORKDIR /home/cod4

RUN chmod +x script.sh
ENTRYPOINT ["/home/cod4/script.sh"]

VOLUME ["/home/cod4/main"]
VOLUME ["/home/cod4/zone"]
VOLUME ["/home/cod4/mods"]
VOLUME ["/home/cod4/usermaps"]
VOLUME ["/home/cod4/main/server.cfg"]
