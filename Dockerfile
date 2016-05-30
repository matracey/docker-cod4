FROM centos:7
MAINTAINER matracey

#from http://cod4-linux-server.webs.com/
RUN yum -y install glibc.i686 libgcc.i686 libstdc++.i686 zlib.i686

RUN useradd cod4
ADD cod4 /home/cod4/
RUN chown -R cod4:cod4 /home/cod4

USER cod4
WORKDIR /home/cod4

ENTRYPOINT ["/home/cod4/cod4x18_dedrun"]

CMD ["+set sv_authorizemode '-1'", "+exec server.cfg", "+map_rotate"]