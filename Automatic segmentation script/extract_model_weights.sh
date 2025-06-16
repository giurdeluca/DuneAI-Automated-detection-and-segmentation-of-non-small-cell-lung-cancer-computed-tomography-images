#!/bin/bash

# --- 1. Check if an input directory was provided ---
if [ -z "$1" ]; then
    echo "Error: You must provide the path to the model files directory."
    echo "Usage: $0 <path_to_directory>"
    exit 1
fi

# --- 2. Assign the directory path from the first argument ---
model_files_path="$1"

# --- 3. Define the full paths for the weight files ---
# Using quotes is a best practice to handle paths with spaces
weight1="$model_files_path/weights_v7.zip.001"
weight2="$model_files_path/weights_v7.zip.002"

# --- 4. Check if the weight files actually exist ---
if [ ! -f "$weight1" ] || [ ! -f "$weight2" ]; then
    echo "Error: Weight files not found in the specified directory: $model_files_path"
    exit 1
fi

# --- 5. Combine the files. The output is a new zip file inside the same directory ---
cat "$weight1" "$weight2" > "$model_files_path/combined_weights.zip"

# --- 6. THIS IS THE CORRECTED LINE ---
# Unzip the file and extract its contents INTO the model_files_path directory.
unzip -o "$model_files_path/combined_weights.zip" -d "$model_files_path"

# --- 7. (Optional) Remove the temporary combined zip file ---
rm "$model_files_path/combined_weights.zip"

echo "Done. Weights are uncompressed in: $model_files_path"
