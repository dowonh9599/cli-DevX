#!/bin/bash

# Function to display usage information
usage() {
    echo "Usage: $0 [--token GITHUB_TOKEN]"
    exit 1
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --token) GITHUB_TOKEN="$2"; shift ;;
        *) usage ;;
    esac
    shift
done

# Check if the token is provided
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GitHub token is required."
    usage
fi

# Configuration
REPO_OWNER="owner"
REPO_NAME="repo"

# GitHub API URL
API_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/commits"

get_current_branch_name() {
    git rev-parse --abbrev-ref HEAD
}

# Call the function and store the current branch name
CURRENT_BRANCH=$(get_current_branch_name)
echo $CURRENT_BRANCH

# Function to get the latest commit hash
get_latest_commit_hash() {
    curl -s -H "Authorization: token $GITHUB_TOKEN" "$API_URL?sha=$CURRENT_BRANCH" | jq -r '.[0].sha'
}

# Call the function and get the latest commit hash
LATEST_COMMIT_HASH=$(get_latest_commit_hash)
if [ -z "$LATEST_COMMIT_HASH" ]; then
    echo "Error: Could not retrieve the latest commit hash."
    exit 1
fi

SHORT_COMMIT_HASH=${LATEST_COMMIT_HASH:0:7}
TODAYS_DATE=$(date +%Y%m%d)

DOCKER_IMAGE_TAG="v$TODAYS_DATE-$SHORT_COMMIT_HASH"
docker build -t visionari-app:$DOCKER_IMAGE_TAG . --platform linux/amd64 --no-cache

# Exit the script
exit 0
