#!/bin/bash
#
# carthage-build.sh
# Build xcframeworks using Carthage
#

# Get directory of script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Move to project directory
cd "${SCRIPT_DIR}/.."

# Run Carthage build
carthage build --no-skip-current --use-xcframeworks
