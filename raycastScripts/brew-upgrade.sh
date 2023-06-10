#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title brew upgrade
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author andre
echo "starting upgrade" &&
brew -q update &&
echo "downloaded updates, installing";
brew -q upgrade &&
echo "cleaning up" &&
brew -q autoremove &&
brew cleanup;
