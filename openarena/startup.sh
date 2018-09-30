#!/bin/sh

# Check for external config files and update if needed
if [ -f /data/server.cfg ]
then
	echo "[INFO] Found server configuration file, adding it to server"
	rm -f /opt/openarena/baseoa/server.cfg
	ln -s /data/server.cfg /opt/openarena/baseoa/server.cfg
fi

if [ -f /data/maprotation.cfg ]
then
	echo "[INFO] Found map rotation configuration file, adding it to server"
	rm -f /opt/openarena/baseoa/maprotation.cfg
	ln -s /data/maprotation.cfg /opt/openarena/baseoa/maprotation.cfg
fi

if [ -f /data/motd.cfg ]
then
	echo "[INFO] Found motd configuration file, adding it to server"
	rm -f /opt/openarena/baseoa/motd.cfg
	ln -s /data/motd.cfg /opt/openarena/baseoa/motd.cfg
fi

# Check for log file
if [ ! -f /data/games.log ]
then
	echo "[INFO] No external log file found, creating one"
	touch /data/games.log
	mkdir -p /root/.openarena/baseoa 2> /dev/null && ln -s /data/games.log /root/.openarena/baseoa/games.log
else
	echo "[INFO] External log file found, using it"
	rm -f /root/.openarena/baseoa/games.log 2> /dev/null
	mkdir -p /root/.openarena/baseoa 2> /dev/null && ln -s /data/games.log /root/.openarena/baseoa/games.log
fi

# Add external pk3 files
if [ -d /data/pk3s ]
then
	cd /data/pk3s && ls *.pk3 2> /dev/null 1> /tmp/list_pk3.txt
	while read i; do
		echo "[INFO] Found $i pk3 file, adding it to server"
		ln -s /data/pk3s/$i /opt/openarena/baseoa/$i
	done </tmp/list_pk3.txt
fi

# Start the server
/opt/openarena/oa_ded.x86_64 +set dedicated 1 +exec server.cfg
