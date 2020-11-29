#!/bin/sh

: "${APPLE_TEAM_ID?Please set APPLE_TEAM_ID in your env.}"
: "${FASTLANE_USER?Please set FASTLANE_USER in your env.}"
: "${FASTLANE_PASSWORD?Please set FASTLANE_PASSWORD in your env.}"

export FASTLANE_DONT_STORE_PASSWORD=1

bundle install

bundle exec fastlane build \
    scheme:"$1" \
    apple_team_id:"$APPLE_TEAM_ID"
