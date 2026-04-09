#!/bin/bash

sudo mkdir -p /etc/apt/keyrings
curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xF60F4B3D7FA2AF80" | sudo gpg --dearmor -o /etc/apt/keyrings/nvidia-devtools.gpg

echo "deb [signed-by=/etc/apt/keyrings/nvidia-devtools.gpg] https://developer.download.nvidia.com/devtools/repos/ubuntu$(. /etc/os-release; echo ${VERSION_ID//./})/$(dpkg --print-architecture) /" | sudo tee /etc/apt/sources.list.d/nvidia-devtools.list
sudo apt update 
sudo apt install -y nsight-systems nsight-systems-cli