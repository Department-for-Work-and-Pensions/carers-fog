#!/bin/sh

HOME_DIR=`dirname $0`

${HOME_DIR}/gelflog grayloghost dt-admin-01 "Checking Preview" "Checking if Preview should start or stop" 6 "Start/Stop" "Preview" "checkPreview" 

source /etc/carers-fog.conf

curl --insecure ${WIKI_CAL} > /tmp/ics.txt

python ${HOME_DIR}/findEvent.py

retCode=$?

if [ "$retCode" -eq "0" ]; then
  ${HOME_DIR}/preview_start_stop IL2 stop
  ${HOME_DIR}/preview_start_stop IL3 stop
  ${HOME_DIR}/gelflog grayloghost dt-admin-01 "Stopping Preview" "Stopping Preview" 6 "Start/Stop" "Preview" "checkPreview" 
elif [ "$retCode" -eq "1" ]; then
  ${HOME_DIR}/preview_start_stop IL2 start
  ${HOME_DIR}/preview_start_stop IL3 start
  ${HOME_DIR}/gelflog grayloghost dt-admin-01 "Starting Preview" "Starting Preview" 6 "Start/Stop" "Preview" "checkPreview" 
else
  ${HOME_DIR}/gelflog grayloghost dt-admin-01 "Check of preview start/stop failed" "Failed with errorcode ${retCode}" 3 "Start/Stop" "Preview" "checkPreview" 
fi

