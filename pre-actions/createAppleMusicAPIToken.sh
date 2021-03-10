#!/bin/sh

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Delete any existing key/token FIRST so that if rest of script fails, app will not run (Xcode does not fail build from a failing pre-action).
sed -i '' "/APPLE_MUSIC_API_TOKEN/d" $SRCROOT/redbook/Configuration/secrets.xcconfig

echo "Generating Apple Music API Token."

# Exit if any of the required variables are not available.
# They are set in secrets.xcconfig and made available to this script by the Xcode pre-action bootstrapping.
: "${APP_STORE_CONNECT_TEAM_ID?Please set APP_STORE_CONNECT_TEAM_ID in your secrets.xcconfig.}"
: "${APPLE_MUSIC_KEY_ID?Please set APPLE_MUSIC_KEY_ID in your secrets.xcconfig.}"
: "${APPLE_MUSIC_PRIVATE_KEY?Please set APPLE_MUSIC_PRIVATE_KEY in your secrets.xcconfig.}"

# Generate the token using the amtg helper [https://github.com/breakbeat-io/amtg]
JWT=$($SCRIPTPATH/amtg -k "$APPLE_MUSIC_PRIVATE_KEY" -i "$APPLE_MUSIC_KEY_ID" -t "$APP_STORE_CONNECT_TEAM_ID")

# Add the generated token as a new line
echo "APPLE_MUSIC_API_TOKEN = $JWT" >> $SRCROOT/redbook/Configuration/secrets.xcconfig

echo "Apple Music API Token added to secrets.xcconfig successfully."
