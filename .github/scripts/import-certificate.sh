#!/bin/bash

set -euo pipefail

security create-keychain -p "" build.keychain
security list-keychains -s build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p "" build.keychain
security set-keychain-settings
security import <(echo $APP_STORE_SIGNING_CERTIFICATE | base64 --decode) \
                -f pkcs12 \
                -k build.keychain \
                -P $APP_STORE_SIGNING_CERTIFICATE_PASSWORD \
                -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple: -s -k "" build.keychain