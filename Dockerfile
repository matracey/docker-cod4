FROM ubuntu
ENV LANG=da_DK.UTF-8
ENV LANGUAGE=da_DK

# Running options to COD4 server 
ENV READY=""
ENV PORT="28960"
ENV MODNAME=""
ENV MAP="+map_rotate"
ENV EXTRA=""
ENV SERVERTYPE=""
ENV EXECFILE=""

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y lib32stdc++6 unzip curl nano

RUN groupadd -r cod4 && useradd --no-log-init -r -g cod4 cod4
ADD cod4 /home/cod4/
RUN chown -R cod4:cod4 /home/cod4

USER cod4
WORKDIR /home/cod4

RUN chmod +x script.sh
ENTRYPOINT ["/home/cod4/script.sh"]

VOLUME ["/home/cod4/gamefiles/"]
