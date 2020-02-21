#!/bin/bash
# This script should be called on thursday.

[ -z "$DL_DIR" ] && { echo "Error: DL_DIR is not set!"; exit 1; }
[ -z "$WEBHOOK_TRIGGER" ] && { echo "Error: WEBHOOK_TRIGGER is not set!"; exit 1; }
[ -z "$WEBHOOK_KEY" ] && { echo "Error: WEBHOOK_KEY is not set!"; exit 1; }

# if there is an argument passed from command-line, use it as ONAIR_DATE
[ ! -z $1 ] && ONAIR_DATE=$1 || ONAIR_DATE=$(date --date="-1 days" "+%Y%m%d")
FILENAME="miyawaki-${ONAIR_DATE}.mp3"
URL="http://vod.bayfm.jp/VODFILES/artist/${FILENAME}"
WEBHOOK_URI="https://maker.ifttt.com/trigger/${WEBHOOK_TRIGGER}/with/key/${WEBHOOK_KEY}"

function log_info(){
  local MSG=$1
  curl -s -X POST -H "Content-Type: application/json" -d "{\"value1\":\"[sakunoki] ${MSG}\"}" $WEBHOOK_URI > /dev/null
}

function bytes_for_humans(){
  local -i bytes=$1;
  if [[ $bytes -lt 1024 ]]; then
    echo "${bytes}B"
  elif [[ $bytes -lt 1048576 ]]; then
    echo "$(( (bytes + 1023)/1024 ))KB"
  else
    echo "$(( (bytes + 1048575)/1048576 ))MB"
  fi
}

if [ ! -d "${DL_DIR}" ]; then
  log_info "No such directory: ${DL_DIR}"
  exit 1
fi

cd "$DL_DIR"
ERROR_MSG=$(curl --silent --show-error --fail -O "${URL}" 2>&1)
if [ "$?" -ne 0 ]; then
  log_info "${ERROR_MSG} (FILENAME: $FILENAME)"
  exit 1
fi

DOWNLOADED_BYTES=$(stat --format=%s "${DL_DIR}/${FILENAME}")
log_info "${FILENAME} downloaded ($(bytes_for_humans $DOWNLOADED_BYTES))"
