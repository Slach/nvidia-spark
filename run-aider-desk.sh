#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"

# aider-desk GUI
AIDER_DESK_VERSION=$(curl -sL https://github.com/hotovo/aider-desk/releases/latest -H "Accept: application/json" | jq -r .tag_name)
AIDER_DESK_VERSION=${AIDER_DESK_VERSION#v}

YAML=~/aider-desk/latest-linux.yml
FILE=~/aider-desk/aider-desk.AppImage
ARCH="x86_64"
YAML_REMOTE=latest-linux.yml
if [[ "arm64" == "$( dpkg --print-architecture)" ]]; then
  ARCH="arm64"
  YAML_REMOTE=latest-linux-arm64.yml
fi

# extract version from existing YAML if it exists
EXISTING_VERSION=""
if [[ -f "$YAML" ]]; then
  EXISTING_VERSION=$(yq e '.version' $YAML 2>/dev/null | sed 's/^v//')
fi

mkdir -p ~/aider-desk/

# Download YAML and check version match
wget --progress=bar:force:noscroll -O "${YAML}" https://github.com/hotovo/aider-desk/releases/download/v${AIDER_DESK_VERSION}/${YAML_REMOTE}

# Check if version in YAML matches AIDER_DESK_VERSION
if [[ "$EXISTING_VERSION" == "$AIDER_DESK_VERSION" ]]; then
  echo "Version $AIDER_DESK_VERSION already downloaded, skipping AppImage download"
else
  rm -rf "$FILE"
  wget --progress=bar:force:noscroll -O "${FILE}" https://github.com/hotovo/aider-desk/releases/download/v${AIDER_DESK_VERSION}/aider-desk-${AIDER_DESK_VERSION}-${ARCH}.AppImage
fi

# extract sha512

EXTRACTED_BASE64=$(yq e '.files[] | select(.url | test("aider-desk.*'${ARCH}'\.AppImage$")) | .sha512' $YAML)
EXPECTED_HEX=$(echo "$EXTRACTED_BASE64" | base64 --decode | xxd -p -c 128)
ACTUAL_HEX=$(sha512sum $FILE | awk '{print $1}')

# Compare
if [ "$EXPECTED_HEX" = "$ACTUAL_HEX" ]; then
  echo "Checksum matches! File is valid."
else
  echo "Checksum mismatch! File may be corrupted or tampered."
  exit 1
fi
sudo chmod +x ~/aider-desk/aider-desk.AppImage

if screen -list | grep -q "aider-desk"; then
  screen -S aider-desk -X quit
fi

pgrep -af aider-desk


AIDER_DESK_HEADLESS=true AIDER_DESK_USERNAME=${AIDER_DESK_USERNAME:-aider} AIDER_DESK_PASSWORD=${AIDER_DESK_USERNAME:-aider} ELECTRON_OZONE_PLATFORM_HINT=headless screen -L -Logfile /tmp/aider-desk.log -dmS aider-desk /home/slach/aider-desk/aider-desk.AppImage --no-sandbox --headless
screen -list