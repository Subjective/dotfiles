#!/bin/sh

# Function to create the directory structure
create_directory_structure() {
    SOURCE_PATH=$1
    DOTFILES_PATH=$2
    BACKUP_PATH=$3

    # Read the list of directories and files
    while IFS= read -r path; do
        path=$(echo "$path" | xargs) # Trim leading/trailing spaces
        if [ ! -e "$path" ]; then
            echo "Path '$path' does not exist. Skipping."
            continue
        fi

        if [ ! "$path" = "${path#".config/"}" ]; then
            # If the path starts with .config/, it is a subdirectory of .config
            relative_path="${path#".config/"}"
            destination_dotfiles="$DOTFILES_PATH/$relative_path"
            destination_backup="$BACKUP_PATH/$relative_path"
        else
            # Otherwise, it is not a subdirectory of .config
            read -p "Enter the subdirectory name for '$path': " subdirectory_name
            destination_dotfiles="$DOTFILES_PATH/$subdirectory_name/$(basename "$path")"
            destination_backup="$BACKUP_PATH/$subdirectory_name/$(basename "$path")"
        fi

        mkdir -p "$(dirname "$destination_dotfiles")"
        mkdir -p "$(dirname "$destination_backup")"

        if [ -d "$path" ]; then
            cp -R "$path" "$destination_backup"
            mv "$path" "$destination_dotfiles"
        else
            cp "$path" "$destination_backup"
            mv "$path" "$destination_dotfiles"
        fi

        echo "Moved '$path' to '$destination_dotfiles'"
        echo "Backed up '$path' to '$destination_backup'"

    done < "$SOURCE_PATH"
}

read -p "Enter the path to the file containing the list of directories and files: " SOURCE_LIST_PATH
read -p "Enter the path to the dotfiles directory: " DOTFILES_DIRECTORY

# Set the backup location to ".backup/" relative to the current working directory
BACKUP_DIRECTORY="$(pwd)/.backup"

create_directory_structure "$SOURCE_LIST_PATH" "$DOTFILES_DIRECTORY" "$BACKUP_DIRECTORY"
