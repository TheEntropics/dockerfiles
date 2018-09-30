#!/bin/sh -eux

# Get openarena if .zip not available
if [ ! -f /openarena.zip ]; then
    echo "Downloading OpenArena..."
    wget "https://netix.dl.sourceforge.net/project/oarena/openarena-0.8.8.zip" -O openarena.zip
fi

# Prepare directories
mkdir /opt

# Extract openarena
echo "Unzipping..."
unzip /openarena.zip -d /opt

# Rename openarena folder
mv /opt/openarena* /opt/openarena

# Clean
rm -f /openarena.zip
rm -f /opt/openarena/*.dll /opt/openarena/openarena.*
rm -rf /opt/openarena/__MACOSX /opt/openarena/*.app

# Remove this script
rm /get-server.sh
