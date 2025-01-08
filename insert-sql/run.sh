#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Database connection details
DB_NAME="postgres"                # Replace with your database name
DB_USER="postgres"                # Replace with your username
DB_PASSWORD="postgres*!L"         # Replace with your password
DB_HOST="127.0.0.1"               # Replace with your host
DB_PORT="5432"                    # Replace with your port

# or you can use load-env
chmod +x $DIR/../load-env/load-env.sh
source $DIR/../load-env/load-env.sh $DIR/../.env || exit 1

# Path to the SQL file
SQL_FILE="path/to/sql"     # Replace with your .sql file path

# Export the password so psql can use it without prompting
export PGPASSWORD=$DB_PASSWORD

# Run the SQL file
psql -h $DB_HOST -p $DB_PORT -d $DB_NAME -U $DB_USER -f $SQL_FILE

# Check if the psql command succeeded
if [ $? -eq 0 ]; then
    echo "SQL script executed successfully."
else
    echo "Error while executing SQL script."
fi

# Unset the password for security
unset PGPASSWORD