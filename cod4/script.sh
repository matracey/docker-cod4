#!/usr/bin/env bash
if [ ! -f gamefiles/cod4x18_dedrun ]; then
    echo "cod4x18_dedrun not found... trying to download it."
    curl https://cod4x.me/downloads/cod4x_server-linux.zip > cod4x.zip && unzip -o cod4x.zip -d gamefiles && rm cod4x.zip
    echo "Download Done"
    chmod +x gamefiles/cod4x18_dedrun
    echo ready
else
  chmod +x gamefiles/cod4x18_dedrun
  echo "cod4x18_dedrun found" 
fi
if [ "$(ls -A gamefiles/main)" ]; then
	echo "Main is Good"
	echo "Testing if xbase_00.iwd is in main"
	if [[ ! -f gamefiles/main/xbase_00.iwd ]]; then
	echo "Xbase_00.iwd not found copying it now"
	cp xbase_00.iwd gamefiles/main/
	echo "Copying xbase_00.iwd done"
	else
	echo "Xbase_00.iwd is Good"
	fi
else
echo "ERROR Main is Empty"
fi
if [ "$(ls -A gamefiles/mods)" ]; then
     echo "Mods Good"
else
    echo "ERROR Mods is Empty"
fi
if [ "$(ls -A gamefiles/usermaps)" ]; then
     echo "Usermaps Good"
else
    echo "ERROR Usermaps is Empty"
fi
if [ "$(ls -A gamefiles/zone)" ]; then
     echo "Zone is Good"
else
    echo "ERROR Zone is Empty"
fi
echo "Setting server type"
if [[ -z "${SERVERTYPE}" ]]; then
  echo "The SERVERTYPE variable is empty."
  SERVERTYPE="1"
fi
echo "Setting port"
if [[ -z "${PORT}" ]]; then
  echo "The PORT variable is empty."
  PORT="28960"
fi
echo "Setting EXTRA arg"
if [[ -z "${EXTRA}" ]]; then
  echo "The EXTRA variable is empty."
  EXTRA="+set sv_authorizemode -1"
fi
echo "Setting exec file"
if [[ -z "${EXECFILE}" ]]; then
  echo "The EXECFILE variable is empty."
  EXECFILE="server.cfg"
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
		gamefiles/cod4x18_dedrun "+set dedicated $SERVERTYPE" "+set net_port $PORT" "+set fs_game mods/$MODNAME" "$EXTRA" "+exec $EXECFILE" "$MAP"
	else
		echo "Not using Mod"
		gamefiles/cod4x18_dedrun "+set dedicated $SERVERTYPE" "+set net_port $PORT" "$EXTRA" "+exec $EXECFILE" "$MAP"
	fi

fi
