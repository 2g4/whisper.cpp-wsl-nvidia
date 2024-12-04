#!/bin/bash

# Set the CUDA_DEB variable with the filename of the local CUDA repository .deb package
# This package is specific to the CUDA version (12.6.3) for WSL (Windows Subsystem for Linux) on Ubuntu
CUDA_DEB="cuda-repo-wsl-ubuntu-12-6-local_12.6.3-1_amd64.deb"

# Define the default path value
DEFAULT_PATH="/var/playground/whisper.cpp"

# Ask for input with the default value pre-filled
echo "Please enter the directory path (default: $DEFAULT_PATH): "
read -r user_input

# If the user doesn't input anything, use the default path
if [ -z "$user_input" ]; then
    DIRECTORY_PATH="$DEFAULT_PATH"
else
    DIRECTORY_PATH="$user_input"
fi

# Show the directory path being used
echo "Using directory path: $DIRECTORY_PATH"

# Check if the directory exists
if [ ! -d "$DIRECTORY_PATH" ]; then
    echo "Directory does not exist. Creating directory: $DIRECTORY_PATH"
    sudo mkdir -p "$DIRECTORY_PATH"  # Create the directory (including parent directories if necessary)
    sudo chown $(whoami):$(whoami) "$DIRECTORY_PATH"
else
    echo "Directory already exists: $DIRECTORY_PATH"
fi

cd "$DIRECTORY_PATH"

# Clone the 'whisper.cpp' repository from GitHub to the current directory
git clone https://github.com/ggerganov/whisper.cpp.git .

# Run the shell script to download the pre-trained 'base.en' GGML model for Whisper
sh ./models/download-ggml-model.sh base.en

# Update system package index and install make, build-essential, and SDL2 development libraries
sudo apt update -y && sudo apt install -y make build-essential libsdl2-dev

# Download the CUDA repository pin file to set the preference for CUDA packages
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin

# Move the pin file to the appropriate directory to prevent the system from upgrading the CUDA packages unintentionally
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600

# Set CUDA package path 
CUDA_DEB_PATH="$DIRECTORY_PATH/$CUDA_DEB"

# If the CUDA .deb package is not already downloaded, fetch it from the NVIDIA repository
if [ ! -f "$CUDA_DEB" ]; then
    wget https://developer.download.nvidia.com/compute/cuda/12.6.3/local_installers/$CUDA_DEB
fi

# Install the CUDA repository package
sudo dpkg -i cuda-repo-wsl-ubuntu-12-6-local_12.6.3-1_amd64.deb

# Copy the CUDA keyring to the keyring directory to verify the packages
sudo cp /var/cuda-repo-wsl-ubuntu-12-6-local/cuda-*-keyring.gpg /usr/share/keyrings/

# Update the apt package list again to include the newly added CUDA repositories
sudo apt update

# Install the necessary CUDA toolkits (CUDA 12.6 and nvidia-cuda-toolkit)
sudo apt -y install cuda-toolkit-12-6 nvidia-cuda-toolkit

# Clean up any previous builds and build the project using multiple threads
make clean && GGML_CUDA=1 make -j

# Run the program with the provided sample input (a .wav file)
./main -f samples/jfk.wav
