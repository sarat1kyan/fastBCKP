#!/bin/bash

echo "let's start"

banner1() {
  local text="$@"
  local length=$(( ${#text} + 2 ))
  local line=$(printf '%*s' "$length" '' | tr ' ' '-')
  echo "+$line+"
  printf "| %s |\n" "$(date)"
  echo "+$line+"
  printf "|$bold%s$reset|\n" "$text"
  echo "+$line+"
}

# Check if script is being run as root
if [[ $EUID -ne 0 ]]; then
  banner1 "This script must be run as root."
  exit 1
fi

#clolors
white='\e[1;37m'
green='\e[0;32m'
blue='\e[1;34m'
red='\e[1;31m'
yellow='\e[1;33m' 
echo "_"
echo "_"
banner() {
	echo -e $'\e[1;33m\e[0m\e[1;37m       █████▒▄▄▄        ██████ ▄▄▄█████▓ ▄▄▄▄    ▄████▄   ██ ▄█▀ ██▓███     \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m     ▓██   ▒▒████▄    ▒██    ▒ ▓  ██▒ ▓▒▓█████▄ ▒██▀ ▀█   ██▄█▒ ▓██░  ██▒   \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m     ▒████ ░▒██  ▀█▄  ░ ▓██▄   ▒ ▓██░ ▒░▒██▒ ▄██▒▓█    ▄ ▓███▄░ ▓██░ ██▓▒   \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m     ░▓█▒  ░░██▄▄▄▄██   ▒   ██▒░ ▓██▓ ░ ▒██░█▀  ▒▓▓▄ ▄██▒▓██ █▄ ▒██▄█▓▒ ▒   \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m     ░▓█▒  ░░██▄▄▄▄██   ▒   ██▒░ ▓██▓ ░ ▒██░█▀  ▒▓▓▄ ▄██▒▓██ █▄ ▒██▄█▓▒ ▒   \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m      ▒ ░    ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░  ▒ ░░   ░▒▓███▀▒░ ░▒ ▒  ░▒ ▒▒ ▓▒▒▓▒░ ░  ░   \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m      ░       ▒   ▒▒ ░░ ░▒  ░ ░    ░    ▒░▒   ░   ░  ▒   ░ ░▒ ▒░░▒ ░        \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m      ░ ░     ░   ▒   ░  ░  ░    ░       ░    ░ ░        ░ ░░ ░ ░░          \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m                  ░  ░      ░            ░      ░ ░      ░  ░               \e[0m'
	echo -e $'\e[1;33m\e[0m\e[1;37m                                              ░ ░                           \e[0m'
	
	
	echo""  
	echo -e $'\e[1;33m\e[0m\e[1;33m    ██████████\e[0m'"\e[96m██████████"'\e[1;33m\e[0m\e[1;31m██████████\e[0m' '\e[1;32m\e[0m\e[1;32m grant root privileges on your android device with sudroid \e[0m''\e[1;37m\e[0m\e[1;37m \e[0m'                                       
	echo ""
	echo -e $'\e[1;33m\e[0m\e[1;33m  [ \e[0m\e[1;32m Follow on Github :- https://github.com/54R4T1KY4N \e[0m \e[1;32m\e[0m\e[1;33m] \e[0m'
	echo ""
	echo -e $'\e[1;37m\e[0m\e[1;37m    +-+-+-+-+-+-+-+ >>\e[0m'
	echo -e "\e[93m    fastBCKP |2|.|1| stable"      
	echo -e $'\e[1;37m\e[0m\e[1;37m    +-+-+-+-+-+-+-+ >>\e[0m' 
	echo ""                                                
}
banner 

# Ask user for directory path to backup
read -p "Enter directory path to backup: " directory

# Check if directory exists
if [ ! -d "$directory" ]; then
  banner1 "Error: Directory not found!"
  exit 1
fi
# Prompt the user to set a password
read -p "Do you want to set a password for the backup? (y/n): " password_choice
if [[ $password_choice =~ ^[Yy]$ ]]; then
    read -sp "Enter the password for the backup: " password
fi

# Prompt the user to set a backup time
read -p "Do you want to schedule the backup? (y/n): " schedule_choice
if [[ $schedule_choice =~ ^[Yy]$ ]]; then
    read -p "Enter the time to schedule the backup (HH:MM): " backup_time
    while [[ ! $backup_time =~ ^([01]?[0-9]|2[0-3]):[0-5][0-9]$ ]]; do
        read -p "Invalid time format. Enter the time to schedule the backup (HH:MM): " backup_time
    done
    current_time=$(date +%H:%M)
    backup_timestamp=$(date -d "$backup_time" +%s)
    current_timestamp=$(date +%s)
    if [[ $backup_timestamp -lt $current_timestamp ]]; then
        backup_timestamp=$((backup_timestamp + 86400))
    fi
    sleep_duration=$((backup_timestamp - current_timestamp))
    at "$backup_time" <<< "bash backup.sh \"$directory\" \"$password\" \"$upload_destination\""
    banner1 "Backup of $directory scheduled for $backup_time. Archive will be saved to $HOME/backups."
    banner1 "You may now close the script. The backup task will run automatically at the scheduled time."
    banner1 "Sleeping for $sleep_duration seconds until backup time."
    sleep $sleep_duration >/dev/null 2>&1
    exit 0
fi

# Create a timestamped subdirectory in the user's home directory
timestamp=$(date +%Y-%m-%d-%H-%M-%S)
backup_dir="$HOME/backups/$directory-$timestamp"
mkdir -p "$backup_dir"

# Compress the contents of the directory into a tar.gz archive
if [[ -n $password ]]; then
    tar -cz "$directory" | openssl enc -aes-256-cbc -pass pass:"$password" -out "$backup_dir/$directory.tar.gz.enc" -pbkdf2 #>/dev/null 2>&1
    #tar -cz "$directory" | openssl enc -aes-256-cbc -pass pass:"$password" -out "$backup_dir/$directory.tar.gz.enc" >/dev/null 2>&1
else
    tar -czf "$backup_dir/$directory.tar.gz" -C "$(dirname "$directory")" "$(basename "$directory")" #>/dev/null 2>&1
    #tar -czf "$backup_dir/$directory.tar.gz" "$directory" >/dev/null 2>&1
fi

# Prompt the user to specify an upload destination
read -p "Do you want to upload the backup archive? (y/n): " upload_choice
if [[ $upload_choice =~ ^[Yy]$ ]]; then
    read -p "Enter the upload destination (user@hostname:/path/to/destination): " upload_destination
    scp "$backup_dir/$directory.tar.gz.enc" "$upload_destination" >/dev/null 2>&1
     if [ $? -eq 0 ]; then
        banner1 "Backup archive uploaded to $upload_destination."
     else
        banner1 "Error: Failed to upload backup archive."
  fi

fi

# Print a success message to the user
banner1 "Backup of $directory completed successfully. Archive saved to $backup_dir."
