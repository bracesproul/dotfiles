#!/bin/bash

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Usage: $0 username:branch_name [repository_name]"
    exit 1
fi

# Split the first argument into username and branch name
FORK_OWNER=$(echo "$1" | cut -d':' -f1)
BRANCH=$(echo "$1" | cut -d':' -f2)

# Set the repository name, default to langchainjs if not provided
REPO_NAME=${2:-langchainjs}

# Define the remote URL with the optional repository name
REMOTE_URL="https://github.com/$FORK_OWNER/$REPO_NAME.git"

# Add remote if it doesn't exist
if ! git remote | grep -q "$FORK_OWNER"; then
    git remote add "$FORK_OWNER" "$REMOTE_URL"
fi

# Fetch the branch and checkout
git fetch "$FORK_OWNER"
git checkout -b "$BRANCH" "$FORK_OWNER/$BRANCH"