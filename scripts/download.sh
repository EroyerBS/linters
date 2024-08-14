#!/bin/bash

#
# @from https://github.com/Halleck45/ast-metrics/blob/main/scripts/download.sh
#

repository="BlusparkTeam/linters"
binary_name="linters"

# Function to get the version of the latest release
function get_latest_release() {
  curl -L --silent "https://api.github.com/repos/$repository/releases/latest" |  # Get latest release from GitHub API
  grep '"tag_name":' |  # Get tag line
  sed -E 's/.*"([^"]+)".*/\1/'  # Pluck JSON value
}

# Function to check OS and architecture
function get_os_arch() {
  os=$(uname -s)
  arch=$(uname -m)
  
  if [[ "$os" == "Linux" ]]; then
    if [[ "$arch" == "i686" || "$arch" == "i386" ]]; then
      echo "Linux_i386"
    elif [[ "$arch" == "x86_64" ]]; then
      echo "Linux_x86_64"
    elif [[ "$arch" == "aarch64" ]]; then
      echo "Linux_arm64"
    else
      echo "Unsupported Linux architecture"
    fi
  elif [[ "$os" == "Darwin" ]]; then
    if [[ "$arch" == "x86_64" ]]; then
      echo "Darwin_x86_64"
    elif [[ "$arch" == "arm64" ]]; then
      echo "Darwin_arm64"
    else
      echo "Unsupported macOS architecture"
    fi
  elif [[ "$os" == "MINGW32" || "$os" == "MSYS" ]]; then
    echo "Windows_i386.exe"  # Assuming 32-bit executable for MSYS/MINGW32
  elif [[ "$os" == "CYGWIN" ]]; then
    # Cygwin can run both 32-bit and 64-bit applications, check further
    if [[ "$(uname -m)" == "x86_64" ]]; then
      echo "Windows_x86_64.exe"
    else
      echo "Windows_i386.exe"
    fi
  elif [[ "$os" == "Windows_NT" ]]; then
    # Check for 64-bit Windows directly
    if [[ $(wmic os get Caption | findstr /i "WOW64") == "" ]]; then  # Not running under WOW64 (32-bit compatibility layer)
      echo "Windows_x86_64.exe"
    else
      echo "Windows_i386.exe"
    fi
  else
    echo "Unsupported OS"
  fi
}

# Get OS and architecture
os_arch=$(get_os_arch)
version=$(get_latest_release)

# Download based on OS and architecture
download_url=""
if [[ "$os_arch" == *"Linux"* ]]; then
  download_url="https://github.com/$repository/releases/download/$version/${binary_name}_$os_arch"
  destination=$binary_name
elif [[ "$os_arch" == *"Darwin"* ]]; then
  download_url="https://github.com/$repository/releases/download/$version/${binary_name}_$os_arch"
  destination=$binary_name
elif [[ "$os_arch" == *"Windows"* ]]; then
  download_url="https://github.com/$repository/releases/download/$version/$os_arch"
  destination=$binary_name.exe
else
  echo "No download available for your system: $os_arch"
  exit 1
fi

if [[ "$download_url" != "" ]]; then
  echo "Downloading $download_url"
  curl -L -o $destination $download_url
fi

# permissions
if [[ "$os_arch" == *"Linux"* || "$os_arch" == *"Darwin"* ]]; then
  chmod +x $destination
fi

echo
echo "File downloaded: $destination"
echo
echo "You can move the executable to a directory in your PATH to make it easier to run."
echo
echo "Example:"
echo "  sudo mv $destination /usr/local/bin/$binary_name"