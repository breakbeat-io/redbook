#!/bin/bash

set -euo pipefail

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
echo "$PROVISIONING_PROFILE" | base64 --decode > ~/Library/MobileDevice/Provisioning\ Profiles/redbook.mobileprovision
