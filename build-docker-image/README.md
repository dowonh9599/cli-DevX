# GitHub-CI Docker Image Builder

This script automates building a Docker image for a project and tagging it based on the latest commit hash and the current date. It leverages a GitHub personal access token to interact with the GitHub API and retrieve the latest commit hash for the current branch.

## Requirements

- Docker installed and running
- `jq` utility installed (used for parsing JSON output)
- A GitHub personal access token with repo permissions (refer to [invalid URL removed])

## How to Use

1. **Configure the Script:**

   - Update the following variables in the script:
     - `REPO_OWNER`: Replace with your GitHub repository owner name.
     - `REPO_NAME`: Replace with your GitHub repository name.

2. **Provide GitHub Token:**

   - Run the script with the `--token` flag followed by your GitHub personal access token:

   ```bash
   bash build-docker-image.sh --token YOUR_GITHUB_TOKEN
   ```

   **Important:** Never share your GitHub personal access token publicly.

## Script Functionality

1. **Parses Arguments:**

   - The script checks for the `--token` flag and extracts the provided GitHub token.
   - If the token is missing, it displays an error message and exits.

2. **Retrieves Latest Commit Hash:**

   - The script defines functions to get the current branch name and retrieve the latest commit hash for that branch from the GitHub API.
   - It uses `curl` to make an authenticated API request and `jq` to parse the JSON response and extract the commit hash.

3. **Builds Docker Image:**
   - The script constructs a Docker image tag incorporating the current date and a shortened version of the latest commit hash.
   - It uses the `docker build` command to build the Docker image for the `visionari-app` application, specifying the target platform (`linux/amd64`) and the `--no-cache` flag to skip using the local cache during the build.

## Output

The script will build the Docker image and display a success message upon completion.

## Security Considerations

- Store your GitHub personal access token securely and avoid committing it to version control.
- Consider using a separate, less privileged token for CI/CD purposes.

I hope this README provides a comprehensive explanation of the script and its functionalities!
