FROM centos:7
MAINTAINER matracey

ENV LANG='da_DK.UTF-8' LANGUAGE='da_DK:da' LC_ALL='da_DK.UTF-8'

#from http://cod4-linux-server.webs.com/
RUN yum -y install glibc.i686 libgcc.i686 libstdc++.i686 zlib.i686

RUN useradd cod4
ADD cod4 /home/cod4/
RUN chown -R cod4:cod4 /home/cod4

USER cod4
WORKDIR /home/cod4

ENTRYPOINT ["/home/cod4/cod4x18_dedrun"]

CMD ["+set sv_authorizemode '-1'", "+exec server.cfg", "+map_rotate"]

VOLUME ["/home/cod4/main"]
VOLUME ["/home/cod4/zone"]
VOLUME ["/home/cod4/mods"]
VOLUME ["/home/cod4/usermaps"]
VOLUME ["/home/cod4/main/server.cfg"]
VOLUME ["/home/cod4/main/games_mp.log"]

EXPOSE 28960 28960/udp
