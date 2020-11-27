#!/bin/bash

set -euo pipefail

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
echo "$PROVISIONING_PROFILE_PRODUCTION" | base64 --decode > ~/Library/MobileDevice/Provisioning\ Profiles/Red_Book_Production.mobileprovision
echo "$PROVISIONING_PROFILE_BETA" | base64 --decode > ~/Library/MobileDevice/Provisioning\ Profiles/Red_Book_Beta.mobileprovision
echo "$PROVISIONING_PROFILE_ALPHA" | base64 --decode > ~/Library/MobileDevice/Provisioning\ Profiles/Red_Book_Alpha.mobileprovision