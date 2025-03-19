#!/bin/bash

# Exit if no argument supplied
if [ -z "$1" ]; then
  echo "Error: No branch name supplied."
  exit 1
fi

# Variables
BRANCH_NAME=$1
WORKTREE_DIR="/Users/bracesproul/code/lang-chain-ai/wt/$BRANCH_NAME"

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
  local PROJECT_TYPE=$2

  echo "Copying .env files to worktree directory..."

  # Copy root .env files
  for root_env_file in "$SOURCE_BASE_DIR"/{.env,credentials.json}; do
    if [ -f "$root_env_file" ]; then
      cp "$root_env_file" "$WORKTREE_DIR/"
      echo "Copied: '$root_env_file' to '$WORKTREE_DIR/'."
    fi
  done

  # Copy project-specific .env files
  if [ "$PROJECT_TYPE" = "langchainjs" ]; then
    local SPECIFIC_DIRS=("langchain" "langchain-core" "examples" "docs/core_docs")
    for dir in "${SPECIFIC_DIRS[@]}"; do
      if [ -f "$SOURCE_BASE_DIR/$dir/.env" ]; then
        cp "$SOURCE_BASE_DIR/$dir/.env" "$WORKTREE_DIR/$dir/"
        echo "Copied: '$SOURCE_BASE_DIR/$dir/.env' to '$WORKTREE_DIR/$dir/'."
      fi
    done
  elif [ "$PROJECT_TYPE" = "langgraphjs" ]; then
    if [ -f "$SOURCE_BASE_DIR/examples/.env" ]; then
      cp "$SOURCE_BASE_DIR/examples/.env" "$WORKTREE_DIR/examples/"
      echo "Copied: '$SOURCE_BASE_DIR/examples/.env' to '$WORKTREE_DIR/examples/'."
    fi
  fi

  # Copy .env files from libs directory
  find "$SOURCE_BASE_DIR/libs" -type f -name ".env" | while read -r file; do
    relative_path="${file#$SOURCE_BASE_DIR/}"
    dest_dir="$WORKTREE_DIR/${relative_path%/*}"
    cp "$file" "$dest_dir/"
    echo "Copied: '$file' to '$dest_dir/'"
  done

  echo "Copied .env files successfully."
}

# Check if the path contains /langchainjs or /langgraphjs
if [[ "$(pwd)" == *"/langchainjs"* ]]; then
  SOURCE_BASE_DIR="/Users/bracesproul/code/lang-chain-ai/langchainjs"
  copy_env_files "$SOURCE_BASE_DIR" "langchainjs"
elif [[ "$(pwd)" == *"/langgraphjs"* ]]; then
  SOURCE_BASE_DIR="/Users/bracesproul/code/lang-chain-ai/langgraphjs"
  copy_env_files "$SOURCE_BASE_DIR" "langgraphjs"
else
  echo "Skipping .env files copying as the path does not include 'langchainjs' or 'langgraphjs'. Current working directory: $(pwd)"
fi



# Navigate to worktree directory
cd $WORKTREE_DIR

# Error handling for cd command
if [ $? -ne 0 ]; then
  echo "Failed to change directory."
  exit 1
fi

# Run yarn install
yarn install

# Error handling for yarn install
if [ $? -ne 0 ]; then
  echo "Yarn install failed."
  exit 1
fi

echo "Worktree created successfully."