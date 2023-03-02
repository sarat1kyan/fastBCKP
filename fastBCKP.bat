@echo off

REM Prompt user to specify directory to backup
set /p backup_dir=Enter directory path to backup:

REM Check if specified directory exists, exit with error message if it doesn't
if not exist %backup_dir% (
    echo Error: Directory does not exist.
    pause
    exit
)

REM Prompt user to set password for backup archive
set /p set_password=Do you want to set a password for the backup archive? (y/n)

if /i "%set_password%"=="y" (
    REM If user chooses to set a password, prompt for password and encrypt archive
    set /p backup_password=Enter password to encrypt backup archive:
    7z a -p%backup_password% backup.7z %backup_dir%
) else (
    REM If user chooses not to set a password, create regular archive
    7z a backup.7z %backup_dir%
)

REM Prompt user to upload backup archive
set /p upload_backup=Do you want to upload the backup archive? (y/n)

if /i "%upload_backup%"=="y" (
    REM If user chooses to upload, prompt for destination path and upload archive
    set /p upload_destination=Enter destination path for backup archive:
    echo Uploading backup archive to %upload_destination%...
    scp backup.7z %upload_destination%
)

echo Backup complete.
pause
