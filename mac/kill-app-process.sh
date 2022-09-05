#!/bin/bash
APP_NAME=APP_NAME
APP_PATH=/Applications/$APP_NAME
APP_LAUNCH_DAEMON=APP_LAUNCH_DAEMON

alias app-off="sudo launchctl unload /Library/LaunchDaemons/${APP_LAUNCH_DEMO} && sudo chmod -x ${APP_PATH}/ && sudo killall ${APP_NAME}"
alias app-on="sudo launchctl load /Library/LaunchDaemons/${APP_LAUNCH_DEMO} && sudo chmod +x ${APP_PATH}/ && open -a ${APP_NAME}"
