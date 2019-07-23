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
echo "ERROR Main is Empty"
fi
if [ "$(ls -A mods)" ]; then
     echo "Mods Good"
else
    echo "ERROR Mods is Empty"
fi
if [ "$(ls -A usermaps)" ]; then
     echo "Usermaps Good"
else
    echo "ERROR Usermaps is Empty"
fi
if [ "$(ls -A zone)" ]; then
     echo "Zone is Good"
else
    echo "ERROR Zone is Empty"
fi
echo "Setting server type"
if [[ -z"${SERVERTYPE}" ]]; then
  echo "The SERVERTYPE variable is empty."
  SERVERTYPE="1"
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
	echo "Config is Ready"
	if [[ ! -z "${MODNAME}" ]]; then
		echo "Mod enabled (using $MODNAME mod)"
		./cod4x18_dedrun "+set dedicated $SERVERTYPE" "+set net_port $PORT" "+set fs_game mods/$MODNAME" "$EXTRA" "+exec server.cfg" "$MAP"
	else
		echo "Not using Mod"
		./cod4x18_dedrun "+set dedicated $SERVERTYPE" "+set net_port $PORT" "$EXTRA" "+exec server.cfg" "$MAP"
	fi

fi
