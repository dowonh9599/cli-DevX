# CSV Data Import Script

This script automates the process of importing CSV files into a PostgreSQL database. It provides two methods for specifying database connection details:

- **Method 1: Hardcoded Credentials**

The script includes pre-defined variables for database connection details, including `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, and `DB_PORT`. You can replace these placeholders with your actual database credentials.

- **Method 2: Using a `.env` File (Recommended)**

The script demonstrates loading environment variables from a separate `.env` file using the `load-env.sh` script (assumed to be located in a `load-env` subdirectory within the project directory). This approach is recommended for improved security practices, as it avoids storing sensitive credentials directly in the script.

## Instructions

1. **Choose your preferred method:**

   - **Hardcoded Credentials:** Update the pre-defined variables (`DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, and `DB_PORT`) with your actual database credentials.
   - **Using a `.env` File:**

     - Create a file named `.env` in the project's root directory.
     - Add your database connection details to the `.env` file in the following format (one variable per line):

     ```
     DB_NAME=your_database_name
     DB_USER=your_username
     DB_PASSWORD=your_password
     DB_HOST=your_host
     DB_PORT=your_port
     ```

     - Ensure the `load-env.sh` script has executable permissions (`chmod +x $DIR/../load-env/load-env.sh`).

2. **Update the CSV directory path:**

   - Modify the `CSV_DIR` variable to point to the directory containing your CSV files.

3. **Review the order of files to import:**

   - The `FILES` array defines the order in which CSV files will be imported. This order is important if there are dependencies between tables.

4. **Run the script:**

   - Execute the script from your terminal:

   ```bash
   bash import_csv_data.sh
   ```

## Security Considerations

- The recommended approach is to use a `.env` file to store your database credentials. This keeps your credentials separate from the script itself, reducing the risk of exposure.
- Remember to grant appropriate execution permissions to the `load-env.sh` script if using the `.env` file method.

## Output

The script will iterate through the specified CSV files, attempting to import each one into the corresponding PostgreSQL table. It will provide messages indicating success or failure for each import operation.

I hope this README provides a clear explanation of the CSV data import script and its configuration!
