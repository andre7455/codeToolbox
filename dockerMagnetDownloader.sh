#!/bin/bash

# Check if a magnet link is provided as an argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <magnet_link>"
  exit 1
fi

MAGNET_LINK="$1"

# Create a Docker container to download the torrent via the magnet link
CONTAINER_NAME="transmission-container-$RANDOM"
DOWNLOAD_DIR=$PWD

docker run --rm -d \
  --name "$CONTAINER_NAME" \
  -v "$DOWNLOAD_DIR":/downloads \
  -e PUID=$(id -u) \
  -e PGID=$(id -g) \
  -e TZ=Europe/Amsterdam \
  -e TRANSMISSION_WEB_HOME=/etc/transmission/web \
  -e USER= \
  -e PASS= \
  -e WHITELIST= \
  -e PEERPORT= \
  -e HOST_WHITELIST= \
  linuxserver/transmission

# Wait for 10 seconds to allow the container to start
sleep 20

# Add the magnet link to Transmission
docker exec "$CONTAINER_NAME" transmission-remote -a "$MAGNET_LINK"

# Start the loop in the background
(
while true; do
    STATUS=$(docker exec "$CONTAINER_NAME" transmission-remote -l | awk 'NR>1 {print $2}')
    # Check if $2 contains "100%"
    if [[ "$STATUS" == *100%* ]]; then
      echo "Download completed. Stopping the container..."
      sleep 60
      docker stop "$CONTAINER_NAME"
      docker rm "$CONTAINER_NAME"
      docker image rm linuxserver/transmission
      break
    fi
    sleep 10
done

# Move and remove folders after the loop finishes
mv "$DOWNLOAD_DIR"/complete/* "$DOWNLOAD_DIR"/
rmdir complete/
rmdir incomplete/
) &
