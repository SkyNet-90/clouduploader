#!/bin/bash

# Check if at least one argument is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <path-to-file...>"
    exit 1
fi

# Define storage account and container names
STORAGE_ACCOUNT_NAME='clouduploaderstor'
CONTAINER_NAME='clouduploadercontainer'

# Get the connection string from the Azure CLI
CONNECTION_STRING=$(az storage account show-connection-string --name $STORAGE_ACCOUNT_NAME --output tsv)

# Process each file provided as an argument
for FILE_PATH in "$@"; do
    echo "Processing: $FILE_PATH"

    # Check if the file exists
    if [ -f "$FILE_PATH" ]; then
        echo "File found, preparing to upload..."

        # File synchronization logic
        if az storage blob exists --container-name $CONTAINER_NAME --name "$(basename "$FILE_PATH")" --connection-string "$CONNECTION_STRING" --output tsv | grep -q true; then
            read -p "File exists. Overwrite (o), skip (s), or rename (r)? " choice
            case "$choice" in
                o) echo "Overwriting...";;
                s) echo "Skipping..."; continue;;
                r) echo "Enter new filename: "; read newname
                   FILE_PATH="$newname"
                   echo "Renaming and uploading...";;
                *) echo "Invalid choice"; exit 4;;
            esac
        fi

        # Encryption
        echo "Encrypting file..."
        gpg -c --output "$FILE_PATH.enc" "$FILE_PATH"
        ENCRYPTED_FILE_PATH="$FILE_PATH.enc"

        # Upload file with progress bar
        echo "Uploading $ENCRYPTED_FILE_PATH..."
        cat "$ENCRYPTED_FILE_PATH" | pv | az storage blob upload --container-name $CONTAINER_NAME --name "$(basename "$ENCRYPTED_FILE_PATH")" --file /dev/stdin --connection-string "$CONNECTION_STRING"

        # Check upload status
        if [ $? -eq 0 ]; then
            echo "Upload successful!"

            # Generate a shareable link
            URL=$(az storage blob url --container-name $CONTAINER_NAME --name "$(basename "$ENCRYPTED_FILE_PATH")" --output tsv)
            echo "Shareable URL: $URL"
        else
            echo "Upload failed!"
            exit 3
        fi
    else
        echo "Error: File does not exist."
        continue
    fi
done
