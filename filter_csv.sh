#!/bin/bash

<<COMMENT
Filter CSV File by Column Names

This script takes column names as arguments and a CSV file path as input, and
creates a new CSV file with only the specified columns.  This is useful in the
context of glue loading being slow, and probably in other contexts.

Usage:
  ./filter_csv.sh <column1> <column2> ... <columnN> <input_file.csv>

Arguments:
	<column1>, <column2>, ..., <columnN>: The names of the columns to include in
	the filtered CSV file.

  <input_file.csv>: The path to the input CSV file.

Example:
  filter_csv.sh "adopted_logg" "adopted_Teff" input.csv

This will create a new CSV file named 'input_filtered.csv' with only the
"adopted_log" and "adopted_Teff" columns from the 'input.csv' file.

Notes:
  - The script assumes that the input CSV file has a header row with column names.
	- If a specified column name is not found in the CSV file, the script will
		display an error message and exit.
	- The output file will be created in the same directory as the input file,
		with "_filtered" appended to the file name.

Author: LGB gently coaxing Claude3 opus.
Date: Thu Apr 25 16:14:39 2024
COMMENT

# Check if the correct number of arguments is provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 <column1> <column2> ... <columnN> <input_file.csv>"
  exit 1
fi

# Get the input file path from the last argument
input_file="${!#}"

# Get the column names from the arguments (excluding the last one)
columns=("${@:1:$#-1}")

# Extract the header line from the input CSV file
header=$(head -n 1 "$input_file")

# Split the header into an array
IFS=',' read -ra header_array <<< "$header"

# Initialize the column indices array
column_indices=()

# Find the index of each specified column in the header
for col in "${columns[@]}"; do
  index=$(printf "%s\n" "${header_array[@]}" | grep -n "^$col$" | cut -d':' -f1)
  if [ -n "$index" ]; then
    column_indices+=("$index")
  else
    echo "Column '$col' not found in the CSV file."
    exit 1
  fi
done

# Generate the output file path by appending "_filtered" to the input file name
output_file="${input_file%.*}_filtered.csv"

# Extract the specified columns from the input CSV file and save them to the output file
cut -d',' -f"${column_indices[*]}" "$input_file" > "$output_file"

echo "Filtered CSV file created: $output_file"
