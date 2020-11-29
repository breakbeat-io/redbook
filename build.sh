#!/bin/sh

: "${APPLE_TEAM_ID?Please set APPLE_TEAM_ID in your env.}"
: "${FASTLANE_USER?Please set FASTLANE_USER in your env.}"
: "${FASTLANE_PASSWORD?Please set FASTLANE_PASSWORD in your env.}"

export FASTLANE_DONT_STORE_PASSWORD=1

branch=$(git symbolic-ref --short -q HEAD)

echo "Installing dependencies ..."
bundle install --quiet	

echo "Starting the build via Fastlane ..."
bundle exec fastlane build branch:"$branch"

