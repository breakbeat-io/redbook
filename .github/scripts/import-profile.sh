#!/bin/bash

set -euo pipefail

echo "Making provisioning profile directory ..."
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

branch=$(git symbolic-ref --short -q HEAD)

case $branch in
"develop")
    provisioningprofile=$PROVISIONING_PROFILE_ALPHA ;;
"beta")
    provisioningprofile=$PROVISIONING_PROFILE_BETA ;;
"release")
    provisioningprofile=$PROVISIONING_PROFILE_RELEASE ;;
*)
    echo "Not on a branch with a provisioing profile - exiting"
    exit 1 ;;
esac

echo "Writing provisioning profile ..."
echo "$provisioningprofile" | base64 --decode > ~/Library/MobileDevice/Provisioning\ Profiles/redbook.mobileprovision
