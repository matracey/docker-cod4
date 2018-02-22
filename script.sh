#!/usr/bin/env bash
if [ ! -f cod4x18_dedrun ]; then
    echo "cod4x18_dedrun not found... trying to download it."
    curl https://cod4x.me/downloads/cod4x_server-linux.zip > cod4x.zip && unzip -o cod4x.zip && rm cod4x.zip
    echo "Download Done"
    chmod +x cod4x18_dedrun
    echo ready
else
  echo "cod4x18_dedrun found" 
fi
if [[ -z "${ARGS}" ]]; then
  echo "The ARGS variable is empty."
  ARGS="+set net_port 28960 +map_rotate"
fi
./cod4x18_dedrun "$ARGS"
