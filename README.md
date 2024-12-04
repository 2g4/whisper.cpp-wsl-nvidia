# whisper.cpp-wsl-nvidia
whisper.cpp-wsl-nvidia is a Bash script that automates the setup of Whisper.cpp on WSL Ubuntu with NVIDIA GPU acceleration. This script configures a WSL 2 environment to leverage NVIDIA's GPU capabilities for faster, more efficient performance while running Whisper.cpp, an efficient implementation of OpenAI's Whisper **speech offline recognition model**.

## Features
- **Automated Setup**: The script simplifies the installation process for setting up Whisper.cpp on WSL Ubuntu.
- **GPU Acceleration**: Enables NVIDIA GPU support on WSL 2 for running Whisper.cpp, speeding up transcription and other tasks.
- **Pre-configured Environment**: Installs all necessary dependencies, such as CUDA and cuDNN, to ensure seamless GPU usage with Whisper.cpp.
- **Easy-to-Use**: Run a single Bash script to configure everything you need to get started with Whisper.cpp on WSL with NVIDIA hardware.


## Prerequisites
Before running the script, ensure you have:

- **WSL 2** installed and configured on your Windows machine.
- An **Ubuntu 24.04.1 LTS** installation in WSL.
- A compatible **NVIDIA GPU** and **NVIDIA drivers** installed on your Windows machine.
- The machine must be running on the **x86_64** architecture.


## Installation & Setup

1. Run the setup script:

    ```bash
    curl -s https://raw.githubusercontent.com/2g4/whisper.cpp-wsl-nvidia/main/nvidia.sh | bash
    ```

2. Follow the on-screen instructions to complete the setup. The script will:

    - Install dependencies (like build-essential, nvidia-cuda-toolkit, etc.).
    - Clone the Whisper.cpp repository.
    Set up NVIDIA GPU support for [Whisper.cpp](https://github.com/ggerganov/whisper.cpp) on WSL 2.
    - Download the [**base.en**](https://huggingface.co/ggerganov/whisper.cpp/blob/main/ggml-base.en.bin) model.

3. Once complete, you can run Whisper.cpp with GPU acceleration in your WSL Ubuntu environment.


## Usage
To use Whisper.cpp with NVIDIA GPU acceleration, simply navigate to the Whisper.cpp directory and run the desired commands as you [normally would](https://github.com/ggerganov/whisper.cpp?tab=readme-ov-file#quick-start). The GPU will automatically be utilized for model inference and processing, greatly improving performance.

## Tested on
* Ubuntu 24.04.1 LTS.
* NVIDIA GeForce RTX 4080 SUPER and 4090 GPUs.



## License
This repository is licensed under the MIT License.