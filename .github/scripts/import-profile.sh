#!/bin/bash

set -euo pipefail

echo "Making provisioning profile directory ..."
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

echo "Writing provisioning profile ..."
echo "$PROVISIONING_PROFILE" | base64 --decode > ~/Library/MobileDevice/Provisioning\ Profiles/redbook.mobileprovision
