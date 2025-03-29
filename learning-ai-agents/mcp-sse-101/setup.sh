#!/bin/bash

apt-get install tree -y

# Define Miniconda installation directory
MINICONDA_DIR="$HOME/miniconda3"

# Install Miniconda if not already installed
if [ ! -d "$MINICONDA_DIR" ]; then
    echo "Installing Miniconda..."
    # Download Miniconda installer
    curl -fsSL -o Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    # Run installer silently (-b: batch mode, -p: installation path)
    bash Miniconda3-latest-Linux-x86_64.sh -b -p "$MINICONDA_DIR"
    # Remove installer
    rm Miniconda3-latest-Linux-x86_64.sh
else
    echo "Miniconda is already installed."
fi

# Initialize Conda for the current shell session
source "$MINICONDA_DIR/etc/profile.d/conda.sh"

# Ensure Conda is initialized in future shell sessions
conda init bash

# Check if the mcp_env environment already exists
if conda info --envs | grep -q "^mcp_env "; then
    echo "Conda environment 'mcp_env' already exists."
else
    echo "Creating Conda environment 'mcp_env' with Python 3.10..."
    # Create the mcp_env environment with Python 3.10
    conda create -y -n mcp_env python=3.11
fi

# Activate the mcp_env environment
conda activate mcp_env

# Configure Conda to activate mcp_env by default in new shell sessions
echo "conda activate mcp_env" >> ~/.bashrc

echo "Setup complete. The 'mcp_env' environment will be activated by default in new shell sessions."

touch /tmp/background0
