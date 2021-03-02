#!/bin/sh

: "${APPLE_TEAM_ID?Please set APPLE_TEAM_ID in your env.}"
: "${APP_STORE_CONNECT_API_KEY_ID?Please set APP_STORE_CONNECT_API_KEY_ID in your env.}"
: "${APP_STORE_CONNECT_API_ISSUER_ID?Please set APP_STORE_CONNECT_API_ISSUER_ID in your env.}"
: "${APP_STORE_CONNECT_API_KEY_CONTENT?Please set APP_STORE_CONNECT_API_KEY_CONTENT in your env.}"

export FASTLANE_DONT_STORE_PASSWORD=1

branch=$(git symbolic-ref --short -q HEAD)

echo "Installing dependencies ..."
bundle install --quiet	

echo "Starting the build via Fastlane ..."
bundle exec fastlane build branch:"$branch"

