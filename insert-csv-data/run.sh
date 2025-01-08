#!/bin/bash

# path settings
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CSV_DIR="$DIR/../csv"

# Database connection details
DB_NAME="postgres"                # Replace with your database name
DB_USER="postgres"                # Replace with your username
DB_PASSWORD="postgres*!L"         # Replace with your password
DB_HOST="127.0.0.1"               # Replace with your host
DB_PORT="5432"                    # Replace with your port


# or you can use load-env
chmod +x $DIR/../load-env/load-env.sh
source $DIR/../load-env/load-env.sh $DIR/../.env || exit 1

# export postgres password as env
export PGPASSWORD="$PG_PASSWORD"

# order of files to copy based on dependencies
FILES=(
  "file1.csv"
  "file2.csv"
  "file3.csv"
  "file4.csv"
  # and more...
)

for CSV_FILE in "${FILES[@]}"; do
  # Extract table name from the CSV filename
  TABLE_NAME=$(basename "$CSV_FILE" .csv)
  QUOTED_TABLE_NAME="\"$TABLE_NAME\""

  echo "Importing '$CSV_FILE' into table '$QUOTED_TABLE_NAME'..."

  # set first row of the CSV file as column names
  COLUMN_NAMES=$(head -n 1 "$CSV_DIR/$CSV_FILE" | tr -d '\r' | awk -F',' '{for (i=1; i<=NF; i++) printf "\"%s\"%s", $i, (i==NF ? "" : ", ")}')
  if [ -z "$COLUMN_NAMES" ]; then
    echo "Error: Could not retrieve column names from '$CSV_FILE'. Skipping..."
    continue
  fi

  echo "Detected column names: $COLUMN_NAMES"

  # Run the \COPY command to import CSV data into PostgreSQL
  psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" <<EOF
\COPY $QUOTED_TABLE_NAME ($COLUMN_NAMES) FROM '$CSV_DIR/$CSV_FILE' WITH (FORMAT csv, HEADER true);
EOF

  # Check if the import was successful
  if [ $? -ne 0 ]; then
    echo "Error: Failed to import '$CSV_FILE' into table '$TABLE_NAME'."
  else
    echo "Successfully imported '$CSV_FILE' into table '$TABLE_NAME'."
  fi
done

# Unset the password after the script runs
unset PGPASSWORD

echo "CSV import process completed."