#!/bin/bash
set -ex

# echo "This is the value specified for the input 'example_step_input': ${example_step_input}"

cd ${app_dir}

VERSION=`cat app.version`.`date '+%y%m%d%H%M'`
# Update version in config.xml
sed -i '' -e "s/0.0.12345/$VERSION/g" "corber/cordova/config.xml"

########################################################################################
# iOS Deployment
########################################################################################
# corber platform add ios@4.5.5
# Currently not working for 5.0.x, issue raised here: https://github.com/apache/cordova-ios/issues/625
corber platform add ios
# corber platform add https://github.com/apache/cordova-ios#0072977e4f173f77867f97ae7ace8af73f8f5dd4


corber build --platform ios --environment cordova --release --build-config "corber/cordova/build.json"

#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:
envman add --key EXAMPLE_STEP_OUTPUT --value 'Test output...'
# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.
