#!/bin/bash

# To schedule every 5 minutes:
# crontab -e
# */5 * * * * /path/to/killspotlight.sh

SPOTLIGHT_PID=$(pgrep Spotlight)

if [ -z "$SPOTLIGHT_PID" ]; then
    echo "Spotlight was not found or is not running."
    exit 1
fi

MEMORY_USAGE=$(ps -o rss= -p $SPOTLIGHT_PID)
MEMORY_USAGE_MB=$((MEMORY_USAGE / 1024))

if [ "$MEMORY_USAGE_MB" -gt 500 ]; then
        kill -9 $SPOTLIGHT_PID
        osascript -e 'tell app "System Events" to display dialog "Spotlight was using too much memory and was killed."'
        exit 0
fi
