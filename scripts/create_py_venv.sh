#!/bin/bash

# Check if a virtual environment name is provided
if [ $# -eq 0 ]; then
    echo "Please provide a name for the virtual environment."
    echo "Usage: $0 <virtual-environment-name>"
    exit 1
fi

# Get the virtual environment name from the command line argument
venv_name=$1

BASE_VIRTUAL_ENV_DIR="/Users/bracesproul/.virtualenvs"

# Create the virtual environment
pyenv virtualenv 3.11 $venv_name

source pyenv activate $venv_name