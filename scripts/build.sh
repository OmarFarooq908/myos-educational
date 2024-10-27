#!/bin/bash

# Navigate to the project root directory where the Makefile is located
cd "$(dirname "$0")/.."

# Run the make command
make

# Optionally, you can also add messages or error handling
if [ $? -eq 0 ]; then
    echo "Build succeeded!"
else
    echo "Build failed!"
    exit 1
fi

