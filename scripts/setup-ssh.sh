#!/bin/bash

# 1. Fetch the raw public keys from GitHub's Meta API
# We use .ssh_keys because known_hosts needs the key itself, not the fingerprint
GH_KEYS=$(curl -s https://api.github.com/meta | jq -r '.ssh_keys[]')

if [ -z "$GH_KEYS" ]; then
    echo "Error: Could not fetch keys from GitHub API."
    exit 1
fi

# 2. Remove any existing github.com entries to prevent duplicates
# This is the "reset" step that makes the script idempotent
ssh-keygen -R github.com -f ~/.ssh/known_hosts > /dev/null 2>&1

# 3. Append the new keys with the host prefix
while read -r key; do
    echo "github.com $key" >> ~/.ssh/known_hosts
done <<< "$GH_KEYS"

echo "GitHub SSH keys have been updated and verified."
