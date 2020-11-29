#!/bin/sh

: "${APPLE_TEAM_ID?Please set APPLE_TEAM_ID in your env.}"
: "${FASTLANE_USER?Please set FASTLANE_USER in your env.}"
: "${FASTLANE_PASSWORD?Please set FASTLANE_PASSWORD in your env.}"

export FASTLANE_DONT_STORE_PASSWORD=1

echo $BRANCH
echo $BRANCH_SUBS

if [ "$GITHUB_ACTION" = true ]
then
	echo "I'm a GitHub Action ..."

	echo "Starting the build via Fastlane ..."
	fastlane build \
    	scheme:"$1" \
    	apple_team_id:"$APPLE_TEAM_ID"
else
	echo "I appear to be running locally ..."

	echo "Installing dependencies ..."
	bundle install --quiet	

	echo "Starting the build via Fastlane ..."
	bundle exec fastlane build \
	    scheme:"$1" \
	    apple_team_id:"$APPLE_TEAM_ID"
fi



