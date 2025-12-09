#!/bin/bash

# Script to build and install the app on a device using Claude Code in a worktree
# This script creates a temporary worktree, runs Claude Code to build and install, then auto-deletes

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PROMPT="Perform the following tasks:
* Apply the stash with the description \"Debuggable automation build\"
* Run ./gradlew :apps:BuyRent:assembleAutomation
* Install it on the running android device using adb. Try to uninstall and then install if you run into any issues on the initial install.
* Launch the app via adb on the device.
* Copy the built apk file into ~/Downloads with the name of the apk file matching the branch name
* Run \"git checkout .\" cleanup the stashed applied so the delete script can cleanup the branch and worktree"

echo "Running build and install workflow in a temporary worktree..."

"$SCRIPT_DIR/worktree-claude.sh" "$PROMPT" -d

