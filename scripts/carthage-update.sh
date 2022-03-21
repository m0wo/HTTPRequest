#!/bin/bash
#
# carthage-update.sh
# Update xcframeworks using Carthage
#

# Get directory of script
SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

# Move to project directory
cd "${SCRIPT_DIR}/.."

# Run Carthage update
carthage update --use-xcframeworks
