#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CONFIG_FILE="$SCRIPT_DIR/youtube.dl.properties"
BATCH_FILE="$SCRIPT_DIR/youtube.batch.txt"
ARCHIVE_FILE="$SCRIPT_DIR/youtube.archive.txt"

touch $ARCHIVE_FILE
youtube-dl --config-location $CONFIG_FILE \
  --batch-file $BATCH_FILE \
  -o "$SCRIPT_DIR/../%(uploader)s/%(title)s/%(title)s.%(ext)s" \
  --download-archive "$ARCHIVE_FILE" #make a list over downloaded files.
