#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title brew upgrade
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author andre
echo "starting upgrade"
brew update
echo "downloaded updates, installing"
brew upgrade
echo "cleaning up"
brew autoremove
brew cleanup 
