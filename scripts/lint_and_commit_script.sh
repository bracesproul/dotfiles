#!/bin/bash

echo "Running format and lint checks..."
yarn format && yarn lint:fix

# Run git status and save the output
git_status_output=$(git status --porcelain)

# Check if any files have changed
if [ -n "$git_status_output" ]; then
  echo "Files have changed, committing..."
  # Replace this with the command commitLint alias represents
  git add -A && git commit -m 'chore: lint files' && git push -u origin $(git rev-parse --abbrev-ref HEAD)
fi
