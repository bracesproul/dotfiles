#!/bin/bash

# Exit if no argument supplied
if [ -z "$1" ]; then
  echo "Error: No branch name supplied."
  exit 1
fi

# Variables
BRANCH_NAME=$1
WORKTREE_DIR="/Users/bracesproul/code/lang-chain-ai/wt/$BRANCH_NAME"

# Check if branch exists, create it if it doesn't
if ! git show-ref --verify --quiet refs/heads/$BRANCH_NAME; then
  echo "Branch '$BRANCH_NAME' doesn't exist. Creating it first..."
  git branch $BRANCH_NAME
  
  # Error handling for branch creation
  if [ $? -ne 0 ]; then
    echo "Branch creation failed."
    exit 1
  fi
  echo "Branch '$BRANCH_NAME' created successfully."
fi

# Create git worktree and navigate to it
git worktree add $WORKTREE_DIR $BRANCH_NAME

# Error handling for git worktree
if [ $? -ne 0 ]; then
  echo "Git worktree creation failed."
  exit 1
fi

# Function to copy env files
copy_env_files() {
  local SOURCE_BASE_DIR=$1

  echo "Copying .env files to worktree directory..."

  # Find all .env files in the source directory and copy them to the worktree directory
  find "$SOURCE_BASE_DIR" -type f \( -name ".env" -o -name ".env.local" -o -name "credentials.json" \) | while read -r file; do
    # Get the relative path from the source base directory
    relative_path="${file#$SOURCE_BASE_DIR/}"
    
    # Create the destination directory if it doesn't exist
    dest_dir="$WORKTREE_DIR/${relative_path%/*}"
    mkdir -p "$dest_dir"
    
    # Copy the file
    cp "$file" "$dest_dir/"
    echo "Copied: '$file' to '$dest_dir/'"
  done

  echo "Copied .env files successfully."
}

# Get the current directory as the source base directory
SOURCE_BASE_DIR="$(pwd)"
copy_env_files "$SOURCE_BASE_DIR"

# Copy top-level secrets directory if it exists
if [ -d "$SOURCE_BASE_DIR/secrets" ]; then
  echo "Copying secrets directory to worktree directory..."
  rsync -a "$SOURCE_BASE_DIR/secrets/" "$WORKTREE_DIR/secrets/"
  if [ $? -ne 0 ]; then
    echo "Secrets directory copy failed."
    exit 1
  fi
  echo "Copied secrets directory successfully."
fi

# Navigate to worktree directory
cd $WORKTREE_DIR

# Error handling for cd command
if [ $? -ne 0 ]; then
  echo "Failed to change directory."
  exit 1
fi

echo "Worktree created successfully."