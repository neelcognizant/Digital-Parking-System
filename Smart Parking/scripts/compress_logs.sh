#!/bin/bash


LOG_DIR="./logs"
ARCHIVE_DIR="./archive"
DATE_SUFFIX=$(date +"%Y-%m-%d")
ARCHIVE_NAME="old_logs_$DATE_SUFFIX.tar.gz"


mkdir -p "$ARCHIVE_DIR"


OLD_LOGS=$(find "$LOG_DIR" -name "*.log" -type f -mtime +7)


if [ -z "$OLD_LOGS" ]; then
  echo "No log files older than 7 days to compress."
  exit 0
fi


TMP_DIR=$(mktemp -d)
echo "Copying old logs to temporary folder: $TMP_DIR"


echo "$OLD_LOGS" | xargs -I {} cp {} "$TMP_DIR"


tar -czf "$ARCHIVE_DIR/$ARCHIVE_NAME" -C "$TMP_DIR" .
echo "Compressed old logs to $ARCHIVE_DIR/$ARCHIVE_NAME"


exit 0
