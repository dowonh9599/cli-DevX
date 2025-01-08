# Dev Scripts

This repository contains a collection of personal shell scripts that I find useful for various tasks.

## Contents

| Script Name           | Description                                                                                                                                                                                                                                |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| build-docker-image.sh | Automates building a Docker image and tagging it based on the latest commit hash and current date. It leverages a GitHub personal access token to interact with the GitHub API and retrieve the latest commit hash for the current branch. |
| docker-colima.sh      | This script provides a simple interface for managing Colima, a lightweight virtual machine for macOS.                                                                                                                                      |
| insert-csv-data.sh    | Automates importing CSV files into a PostgreSQL database. It provides options for specifying database connection details and handles extracting column names from the CSV header row.                                                      |
| insert-sql.sh         | Executes a post-migration SQL script after a database migration process. It provides two methods for specifying database connection details.                                                                                               |
| load-env.sh           | Manages environment variables by loading them from a separate .env file. This promotes better security practices by keeping sensitive credentials out of your main shell scripts.                                                          |
| ssh_cli.sh            | Provides a simple SSH connection manager that reads entries from a file and initiates connections                                                                                                                                          |

## Usage

1. **Clone the repository:**

   ```bash
   git clone <repository_url>
   ```

2. **Navigate to the script directory:**

   ```bash
   cd <repository_name>/<script_directory>
   ```

3. **Execute the desired script:**

   ```bash
   ./<script_name> [arguments]
   ```

### Note

- This repository is for personal use and may not be suitable for production environments.
- Please review and understand the functionality of each script before using them.
- Use these scripts responsibly and at your own risk.

This README provides a basic overview of your repository and can be easily customized to include more specific information about the scripts and their usage.
