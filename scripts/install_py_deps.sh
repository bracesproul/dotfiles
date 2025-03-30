#!/usr/bin/env bash

# Script to install all dependencies from pyproject.toml using uv
# This script is designed to NEVER exit with an error that would close the terminal

# Disable command not found errors
exec 2>/dev/null

# Disable error exit
set +e
set +o pipefail

# Disable all traps that might cause exit
trap '' ERR EXIT SIGTERM SIGINT SIGHUP

# Override the default error handler
trap 'echo "\nCaught an error. Press Enter to continue..."; read -r' ERR

# Function to pause and wait for user input without exiting
pause_for_user() {
    echo -e "\n$1"
    echo "Press Enter to continue..."
    read -r
}

# Function to log errors without exiting
log_error() {
    echo -e "\n[ERROR] $1" >&2
}

# Function to log info messages
log_info() {
    echo -e "\n[INFO] $1"
}

# Main function to wrap all execution
main() {
    # Check if pyproject.toml exists
    if [ ! -f "pyproject.toml" ]; then
        pause_for_user "pyproject.toml not found in current directory. Cannot continue."
        return 1
    fi
    
    # Check if uv is installed
    if ! command -v uv &> /dev/null; then
        pause_for_user "uv is not installed. Please install uv first. See: https://github.com/astral-sh/uv#installation"
        return 1
    fi
    
    log_info "Starting dependency installation..."
    
    # Create a virtual environment if it doesn't exist
    if [ ! -d ".venv" ]; then
        log_info "Creating virtual environment..."
        uv venv || {
            log_error "Failed to create virtual environment."
        }
    fi
    
    # Install the package and its dependencies
    log_info "Installing main dependencies..."
    uv pip install -e . || {
        log_error "Failed to install main dependencies."
    }
    
    # Install test dependencies by properly extracting them from pyproject.toml
    log_info "Installing test dependencies..."
    
    # Safely extract test dependencies
    TEST_DEPS=""
    {
        TEST_DEPS=$(awk '/\[dependency-groups\]/,/\[tool/' pyproject.toml 2>/dev/null | 
                    grep -A 100 'test = \[' 2>/dev/null | 
                    grep -v 'test = \[' 2>/dev/null | 
                    grep '"' 2>/dev/null | 
                    sed 's/^[ \t]*"//' 2>/dev/null | 
                    sed 's/",$//' 2>/dev/null | 
                    sed 's/",$//' 2>/dev/null)
    } || {
        log_error "Failed to extract test dependencies from pyproject.toml"
        TEST_DEPS=""
    }
    
    if [ -n "$TEST_DEPS" ]; then
        log_info "Found test dependencies. Installing..."
        
        # Create a temporary file safely
        TEMP_DEPS_FILE=""
        {
            TEMP_DEPS_FILE=$(mktemp 2>/dev/null)
        } || {
            log_error "Failed to create temporary file. Using fallback method."
            TEMP_DEPS_FILE=".temp_deps_$RANDOM"
            touch "$TEMP_DEPS_FILE" 2>/dev/null
        }
        
        # Write dependencies to file, with error handling
        {
            echo "$TEST_DEPS" > "$TEMP_DEPS_FILE" 2>/dev/null
        } || {
            log_error "Failed to write dependencies to temporary file."
            return 1
        }
        
        # Install each dependency individually with error handling
        while read -r DEP || [ -n "$DEP" ]; do
            if [ -n "$DEP" ]; then
                log_info "Installing: $DEP"
                {
                    uv pip install "$DEP" 2>/dev/null
                } || {
                    log_error "Failed to install dependency: $DEP"
                }
            fi
        done < "$TEMP_DEPS_FILE"
        
        # Clean up temp file safely
        {
            rm -f "$TEMP_DEPS_FILE" 2>/dev/null
        } || {
            log_error "Failed to remove temporary file: $TEMP_DEPS_FILE"
        }
    else
        log_info "No test dependencies found or extraction failed."
    fi
    
    log_info "Dependency installation process completed."
}

# Run the main function in a subshell to contain any errors
{
    main
} || {
    echo -e "\nAn error occurred in the main execution. This is caught and handled."
}

# Always ensure we get to this point
echo -e "\nScript execution completed. Press Enter to exit."
read -r

