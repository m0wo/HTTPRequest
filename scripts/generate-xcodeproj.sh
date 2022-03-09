#!/bin/bash
#
# generate-xcodeproj.sh
# Build xcodeproj file from swift package
#

# Name of the Xcode project
XCODE_PROJECT="HTTPRequest.xcodeproj"

# Get directory of script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Move to project directory
cd "${SCRIPT_DIR}/.."

# Remove previous xcodeproj
rm -rf ${XCODE_PROJECT}

# Generate new xcodeproj
swift package generate-xcodeproj
