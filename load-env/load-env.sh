#!/bin/bash

# Check if a .env file path is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: source load-env.sh /path/to/.env"
  return 1 2>/dev/null || exit 1
fi

ENV_FILE="$1"

# Function to load an .env file
load_env_file() {
  local file="$1"
  
  # Check if the file exists
  if [ ! -f "$file" ]; then
    echo "Error: .env file not found at $file"
    return 1 2>/dev/null || exit 1
  fi

  # Load variables from the file
  set -a # Automatically export all variables loaded from the file
  source "$file"
  set +a
  
  # Check if ENV_FILE is set in the current file
  if [ -n "$ENV_FILE" ] && [ "$ENV_FILE" != "$file" ]; then
    echo "Detected ENV_FILE=$ENV_FILE in $file. Loading referenced file..."
    # Recursively load the referenced ENV_FILE
    load_env_file "$ENV_FILE"
  fi
}

# Load the initial .env file
load_env_file "$ENV_FILE"

# Optional: Validate required variables
REQUIRED_VARS=("POSTGRES_USER" "POSTGRES_NAME" "POSTGRES_PASSWORD" "POSTGRES_HOST" "POSTGRES_PORT")
for VAR in "${REQUIRED_VARS[@]}"; do
  if [ -z "${!VAR}" ]; then
    echo "Error: Required environment variable $VAR is not set."
    return 1 2>/dev/null || exit 1
  fi
done

echo "Environment variables successfully loaded from $ENV_FILE (and any referenced files)"