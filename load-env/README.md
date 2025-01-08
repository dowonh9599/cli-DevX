# load-env.sh

This script is designed to load environment variables from a specified `.env` file. It also supports loading nested `.env` files, allowing for a more organized and modular approach to environment variable management.

## Usage

```bash
source load-env.sh /path/to/.env
```

## Arguments

- `path/to/.env`: The path to the `.env` file containing the environment variables to be loaded.

## Functionality

1. **Argument Validation:**

   - The script checks if a file path is provided as an argument.
   - If no argument is provided, it displays an error message and exits with a non-zero status code.

2. **Loading the `.env` File:**

   - The script stores the provided file path in the `ENV_FILE` variable.
   - It defines a function `load_env_file` that takes a file path as input.
   - The function checks if the file exists. If not, it displays an error message and exits.
   - If the file exists, the function uses the `source` command to load the variables from the file into the current shell environment.
   - The `set -a` and `set +a` commands are used to ensure that all loaded variables are automatically exported.
   - The function recursively checks for a variable named `ENV_FILE` within the loaded file.
   - If `ENV_FILE` is found and points to a different file, the function calls itself recursively to load the referenced file.

3. **Optional: Variable Validation:**

   - The script defines an optional validation step to check for required environment variables.
   - It provides a list of required variables in the `REQUIRED_VARS` array.
   - The script iterates through the `REQUIRED_VARS` array and checks if each variable is set.
   - If a required variable is missing, the script displays an error message and exits.

4. **Success Message:**
   - If all steps are successful, the script displays a message indicating that the environment variables have been loaded successfully from the specified file (and any referenced files).

## Benefits

- **Centralized Configuration:** Stores environment variables in a separate file, keeping your code clean and organized.
- **Improved Maintainability:** Makes it easier to manage and update environment variables without modifying your code.
- **Nested Files:** Supports loading variables from nested `.env` files, promoting modularity and reusability.
- **Optional Validation:** Provides an optional layer of validation to ensure required environment variables are set.

## How to Use

1. Create a file named `.env` in your project directory.
2. Add your environment variables to the `.env` file, following the format `KEY=VALUE` (one variable per line).
3. In your shell script, source the `load-env.sh` script, providing the path to your `.env` file as an argument:

```bash
source load-env.sh .env  # Assuming your .env file is in the current directory
```

Now, you can access the loaded environment variables within your shell script using their corresponding names (e.g., `$POSTGRES_USER`, `$POSTGRES_PASSWORD`).
