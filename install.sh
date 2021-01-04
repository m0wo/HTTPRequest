#!/bin/bash

# Run Carthage update
./carthage.sh update

# ADD THIS WHEN CARTHAGE ROLL IT OUT
# Via Carthage, build platform-independent xcframeworks (Xcode 12 and above)
# carthage update --use-xcframeworks
