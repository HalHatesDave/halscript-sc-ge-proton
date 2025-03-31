#!/usr/bin/env bash
################################################################################################################################
###         Hal's Install-Script for SC using UMU 20Launcher ver 1.0
###         !! REQUIRES UMU TO BE INSTALLED !!
###         (Will auto-install latest GE-Proton)
################################################################################################################################
### Hello:
echo -e "\n\033[1;33m
  ██╗  ██╗ █████╗ ██╗
  ██║  ██║██╔══██╗██║
  ███████║███████║██║
  ██╔══██║██╔══██║██║
  ██║  ██║██║  ██║███████╗
  ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
\033[0m"
echo "Hal's Star Citizen install script now running..."
################################################################################################################################
INSTALL_PATH="$HOME/Games/star-citizen-test" # sets install path, default to ~/Games/star-citizen,
### Set Variables for Download:
################################################################
DOWNLOAD_SOURCE="https://install.robertsspaceindustries.com/rel/2/RSI%20Launcher-Setup-2.3.1.exe"
DEST_DIR="$HOME/Downloads" #sets Download path for installer, default: ~/Downloads
FILENAME=$(basename "$DOWNLOAD_SOURCE")
DEST_FILE="$DEST_DIR/$FILENAME"
################################################################
### Check if file already exists, if so check with user, if not download.
################################################################
echo "Downloading $FILENAME..."

if [[ -f "$DEST_FILE" ]]; then
    echo "File already exists: $DEST_FILE"
    read -p "Do you want to redownload it? (y/N): " choice
    case "$choice" in
        y|Y ) echo "Redownloading..."; rm "$DEST_FILE" ;;
        * ) echo "Using existing file." ;;
    esac
fi

if [[ ! -f "$DEST_FILE" ]]; then
    echo "Downloading $FILENAME..."
    wget -O "$DEST_FILE" "$DOWNLOAD_URL"

    # Check if the download was successful
    if [[ $? -ne 0 ]]; then
        echo "Download failed!"
        exit 1
    fi
fi

chmod +x "$DEST_FILE" #Make Launcher Launchable
################################################################
### Set ENV and run RSI Installer at given Wine Prefix
echo "Applying ENV..."
export WINEPREFIX=$INSTALL_PATH # Star Citizen PFX Location
export GAMEID="umu-starcitizen" # needed for UMU / Protontricks auto-fixes
export STORE=none # Optional, might help Protontricks auto-fixes
export PROTONPATH="GE-Proton" ## Downloads latest GE-Proton and uses it
sleep .5
echo -e "\n\033[1;33m
╔═════════════════════════════════════════════════════════════════════════╗
║         HEADS UP!    #        HEADS UP!      #      HEADS UP!           ║
╚═════════════════════════════════════════════════════════════════════════╝
\033[0m\n After installing, edit sc-proton.sh's WINEPFX variable to the prefix used here (if modified) before running"
echo "In the launcher, you will need to change the game installation DIR to something like Z:\path\to\prefix\star-citizen\drive_c\Program Files\Roberts Space Industries"
echo "!! Make sure to change the linux /'s to Windows \ in the path!!"
sleep 5
echo "Launching with UMU..."
umu-run "$DEST_FILE"
################################################################

