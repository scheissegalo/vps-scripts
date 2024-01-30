#!/bin/bash

# Store repository URL
repository_url="https://github.com/scheissegalo/vps-scripts"

# Get latest commit hash from remote (safer than tags for potential non-tag updates)
latest_remote_hash=$(git ls-remote $repository_url HEAD | cut -f1)

# Get current commit hash
current_commit_hash=$(git rev-parse HEAD)

# Compare hashes (more robust than comparing arbitrary version numbers)
if [[ $latest_remote_hash != $current_commit_hash ]]; then
  echo "Update available! Updating to $latest_remote_hash..."

  # Proceed with update
  git fetch origin
  git reset --hard origin/main  # Assuming main branch

  echo "Update complete!"
else
  echo "No updates available."
fi
