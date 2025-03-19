#!/bin/bash

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Usage: $0 username:branch_name [repo_name]"
    exit 1
fi

# Split the first argument into username and branch name
INPUT_USERNAME=$(echo $1 | cut -d':' -f1 | cut -d'/' -f1)
INPUT_BRANCH=$(echo $1 | cut -d':' -f2- | tr ':' '/')

# Set the repository name (default to "langchainjs" if not provided)
REPO_NAME=${2:-langchainjs}

echo "Checking out $1, $INPUT_USERNAME's $INPUT_BRANCH branch from $REPO_NAME..."

# Define the remote URL
REMOTE_URL="https://github.com/$INPUT_USERNAME/$REPO_NAME.git"

# Add remote if it doesn't exist
if ! git remote | grep -q "$INPUT_USERNAME"; then
    git remote add "$INPUT_USERNAME" "$REMOTE_URL"
else
    git remote set-url "$INPUT_USERNAME" "$REMOTE_URL"
fi

# Fetch the branch
if ! git fetch "$INPUT_USERNAME"; then
    echo "Error: Failed to fetch from $REMOTE_URL"
    exit 1
fi

# Checkout the branch
if git checkout -b "$INPUT_BRANCH" "$INPUT_USERNAME/$INPUT_BRANCH"; then
    echo "Successfully checked out $INPUT_BRANCH"
else
    echo "Error: Failed to checkout branch $INPUT_BRANCH"
    echo "Attempting to checkout existing branch..."
    if git checkout "$INPUT_BRANCH"; then
        echo "Successfully checked out existing branch $INPUT_BRANCH"
    else
        echo "Error: Failed to checkout existing branch $INPUT_BRANCH"
        exit 1
    fi
fi