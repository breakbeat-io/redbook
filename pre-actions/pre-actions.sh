#!/bin/sh

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Redirect output to a file for troubleshooting.
exec > $SCRIPTPATH/pre-actions.log 2>&1

# Add any pre-actions before making the build here.  The project environment
# will be available to the scripts.

$SCRIPTPATH/createAppleMusicAPIToken.sh
