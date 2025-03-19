#!/bin/bash

# Check if a virtual environment name is provided
if [ $# -eq 0 ]; then
    echo "Please provide a name for the virtual environment."
    echo "Usage: $0 <virtual-environment-name>"
    exit 1
fi

# Get the virtual environment name from the command line argument
venv_name=$1

source pyenv activate $venv_name
