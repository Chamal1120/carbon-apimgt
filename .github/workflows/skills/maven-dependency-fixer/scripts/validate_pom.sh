#!/bin/bash

# Check if xmllint is installed
if ! command -v xmllint &> /dev/null; then
    echo "xmllint not found. Installing libxml2-utils..."
    sudo apt-get update -qq && sudo apt-get install -y -qq libxml2-utils
fi

# Run the validation
if xmllint --noout pom.xml; then
    echo "POM is valid"
    exit 0
else
    echo "POM is broken"
    exit 1
fi
