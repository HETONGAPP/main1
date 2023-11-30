#!/bin/bash

for i in $(seq 0 1 1)
do
    # Use jq to extract "name" and "version" from version.json
    name=$(jq -r ".repositories[$i].name" version.json)
    version=$(jq -r ".repositories[$i].version" version.json)

    # Print the extracted information
    echo "Name: $name"
    echo "Version: $version"

    # Check if the target directory exists, and delete it if it does
    if [ -d "$name" ]; then
        echo "Deleting existing directory: $name"
        rm -rf "$name"
    fi

    # Clone the repository
    git clone --branch "$version" --single-branch --depth=1 "https://github.com/HETONGAPP/$name.git"
done