#!/usr/bin/env bash
if [ ! -f cod4x18_dedrun ]; then
    echo "cod4x18_dedrun not found... trying to download it."
    curl https://cod4x.me/downloads/cod4x_server-linux.zip > cod4x.zip && unzip -o cod4x.zip && rm cod4x.zip
    echo "Download Done"
    chmod +x cod4x18_dedrun
    echo ready
else
  chmod +x cod4x18_dedrun
  echo "cod4x18_dedrun found" 
fi
if [[ -f main ]]; then
	echo "main found"
	if [[ ! -f main/xbase_00.iwd ]]; then
	echo "xbase_00.iwd not found"
	cp xbase_00.iwd main/
	echo "copying xbase_00.iwd done"
	fi
fi
if [[ -z "${PORT}" ]]; then
  echo "The PORT variable is empty."
  PORT="28960"
fi

if [[ -z "${MAP}" ]]; then
  echo "The MAP variable is empty."
  MAP="+map_rotate"
fi
if [[ ! -z "${READY}" ]]; then
./cod4x18_dedrun "+set net_port $PORT" "+set fs_game mods/$MODNAME" "$EXTRA" "+exec server.cfg" "$MAP"
fi
