#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title clear docker
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author andre

echo "stopping all running containers"
docker stop $(docker ps -aq)
echo "removing all stored data"
docker system prune -af --volumes
echo "Done cleaning up!"
