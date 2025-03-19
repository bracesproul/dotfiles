#!/usr/bin/env bash

# Script to install all dependencies from pyproject.toml using uv

# Don't exit on error immediately
set +e

# Function to handle errors
handle_error() {
    echo "Error: $1"
    echo "Script failed. Press Enter to exit."
    read -r
    exit 1
}

# Check if pyproject.toml exists
if [ ! -f "pyproject.toml" ]; then
    handle_error "pyproject.toml not found in current directory."
fi

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    handle_error "uv is not installed. Please install uv first. See: https://github.com/astral-sh/uv#installation"
fi

echo "Starting dependency installation..."

# Create a virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    uv venv
    if [ $? -ne 0 ]; then
        handle_error "Failed to create virtual environment."
    fi
fi

# Install the package and its dependencies
echo "Installing main dependencies..."
uv pip install -e .
if [ $? -ne 0 ]; then
    handle_error "Failed to install main dependencies."
fi

# Install test dependencies by properly extracting them from pyproject.toml
echo "Installing test dependencies..."

# This extracts only the actual dependency lines from the dependency-groups section
TEST_DEPS=$(awk '/\[dependency-groups\]/,/\[tool/' pyproject.toml | grep -A 100 'test = \[' | grep -v 'test = \[' | grep '"' | sed 's/^[ \t]*"//' | sed 's/",$//' | sed 's/",$//')

if [ -n "$TEST_DEPS" ]; then
    echo "Found test dependencies. Installing..."
    
    # Install each dependency individually to avoid parsing errors
    echo "$TEST_DEPS" | while read -r DEP; do
        if [ -n "$DEP" ]; then
            echo "Installing: $DEP"
            uv pip install "$DEP"
            if [ $? -ne 0 ]; then
                handle_error "Failed to install dependency: $DEP"
            fi
        fi
    done
else
    echo "No test dependencies found."
fi

echo "All dependencies installed successfully!"
echo "Press Enter to exit."
read -r
