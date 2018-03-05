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
echo "Testing if Main is empty"
if [ "$(ls -A main)" ]; then
	echo "Main is Good"
	echo "Testing if xbase_00.iwd is in main"
	if [[ ! -f main/xbase_00.iwd ]]; then
	echo "Xbase_00.iwd not found copying it now"
	cp xbase_00.iwd main/
	echo "Copying xbase_00.iwd done"
	else
	echo "Xbase_00.iwd is Good"
	fi
else
echo "Main is Empty"
fi
if [ "$(ls -A mods)" ]; then
     echo "Mods Good"
else
    echo "Mods is Empty"
fi
if [ "$(ls -A usermaps)" ]; then
     echo "Usermaps Good"
else
    echo "Usermaps is Empty"
fi
if [ "$(ls -A zone)" ]; then
     echo "Zone is Good"
else
    echo "Zone is Empty"
fi
echo "Setting port"
if [[ -z "${PORT}" ]]; then
  echo "The PORT variable is empty."
  PORT="28960"
fi
echo "Setting MAP"
if [[ -z "${MAP}" ]]; then
  echo "The MAP variable is empty."
  MAP="+map_rotate"
fi
echo "Checking if READY"
if [[ ! -z "${READY}" ]]; then
	echo "Config is not Ready"
	if [[ ! -z "${MODNAME}" ]]; then
		echo "Mod enabled (using $MODNAME mod)"
		./cod4x18_dedrun "+set net_port $PORT" "+set fs_game mods/$MODNAME" "$EXTRA" "+exec server.cfg" "$MAP"
	else
		echo "Not using Mod"
		./cod4x18_dedrun "+set net_port $PORT" "$EXTRA" "+exec server.cfg" "$MAP"
	fi

fi
