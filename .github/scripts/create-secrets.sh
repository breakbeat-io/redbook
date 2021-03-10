#!/bin/bash

set -euo pipefail

SECRETS=$GITHUB_WORKSPACE/redbook/Configuration/secrets.xcconfig

echo "APP_STORE_CONNECT_TEAM_ID = $APP_STORE_CONNECT_TEAM_ID" > $SECRETS
echo "APPLE_MUSIC_KEY_ID = $APPLE_MUSIC_KEY_ID" >> $SECRETS
echo "APPLE_MUSIC_PRIVATE_KEY = $APPLE_MUSIC_PRIVATE_KEY" >> $SECRETS
