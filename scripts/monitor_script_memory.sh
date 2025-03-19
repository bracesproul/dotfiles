#!/bin/bash

# Start the yarn command in the background
yarn gen:typedoc &
YARN_PID=$!

# Wait for a second to ensure the command has started
sleep 1

# Monitor memory usage every second
while true; do
  if ps -p $YARN_PID > /dev/null; then
    ps -o pid,rss,command -p $YARN_PID
    sleep 1
  else
    echo "yarn gen:typedoc has completed."
    break
  fi
done
