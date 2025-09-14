#!/bin/bash

# This script installs the tools required for BB-Recon.

echo "Starting installation of BB-Recon tools..."

# --- Go tools ---
echo "Installing Go-based tools..."
if ! [ -x "$(command -v go)" ]; then
  echo 'Error: go is not installed. Please install Go (https://golang.org/doc/install) and try again.' >&2
  # For Debian/Ubuntu, you can often install Go with:
  # sudo apt-get update && sudo apt-get install -y golang-go
  exit 1
fi

# Set up Go environment if not already set
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

echo "Installing Assetfinder..."
go install github.com/assetfinder/assetfinder@latest

echo "Installing Subfinder..."
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

echo "Installing GitHub Subdomains..."
go install github.com/gwen001/github-subdomains@latest

echo "Installing Chaos Client..."
go install github.com/chaos-release/chaos-client@latest

echo "Installing httpx..."
go install github.com/projectdiscovery/httpx/cmd/httpx@latest

echo "Installing httprobe..."
go install github.com/tomnomnom/httprobe@latest

echo "Installing Nuclei..."
go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

echo "Installing Waybackurls..."
go install github.com/tomnomnom/waybackurls@latest

echo "Installing amass..."
go install -v github.com/owasp-amass/amass/v4/...@master

echo "Installing gau..."
go install github.com/lc/gau/v2/cmd/gau@latest

echo "Installing naabu..."
go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

echo "Installing ffuf..."
go install github.com/ffuf/ffuf/v2@latest

echo "Installing dalfox..."
go install github.com/hahwul/dalfox/v2@latest

echo "Go-based tools installation complete."

# --- Python tools ---
echo "Installing Python-based tools..."
if ! [ -x "$(command -v pip)" ]; then
    echo "pip is not installed. Please install pip and try again."
    exit 1
fi

echo "Installing paramspider..."
pip install paramspider

echo "Installing LinkFinder..."
git clone https://github.com/GerbenJavado/LinkFinder.git
cd LinkFinder || exit
pip install -r requirements.txt
cd ..
echo "Python-based tools installation complete."


# --- Manual installations ---
echo "---"
echo "The following tools require manual installation from GitHub releases."
echo "Please download the latest binaries for your system, extract them, and move them to /usr/local/bin."
echo "Example commands are provided below, but you will need to replace the version numbers and filenames."
echo "---"

# Findomain
# echo "Findomain: https://github.com/findomain/findomain/releases"
# wget https://github.com/findomain/findomain/releases/download/8.2.1/findomain-linux.zip
# unzip findomain-linux.zip
# chmod +x findomain
# sudo mv findomain /usr/local/bin/findomain

# Aquatone
# echo "Aquatone: https://github.com/michenriksen/aquatone/releases"
# wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
# unzip aquatone_linux_amd64_1.7.0.zip
# sudo mv aquatone /usr/local/bin/

# Subzy
# echo "Subzy: https://github.com/lc/subzy/releases"
# wget https://github.com/L-C/subzy/releases/download/v1.0.2/subzy_1.0.2_linux_amd64.tar.gz
# tar -xvf subzy_1.0.2_linux_amd64.tar.gz
# sudo mv subzy /usr/local/bin/subzy

# Subjack
# echo "Subjack: https://github.com/haccer/subjack/releases"
# wget https://github.com/haccer/subjack/releases/download/v1.3.1/subjack_1.3.1_linux_amd64.tar.gz
# tar -xvf subjack_1.3.1_linux_amd64.tar.gz
# sudo mv subjack /usr/local/bin/subjack

# SocialHunter (Sublist3r)
# echo "SocialHunter (Sublist3r): https://github.com/aboul3la/Sublist3r"
# git clone https://github.com/aboul3la/Sublist3r.git
# cd Sublist3r
# pip install -r requirements.txt
# cd ..

# SubJS
# echo "SubJS: https://github.com/lc/subjs/releases"
# wget https://github.com/lc/subjs/releases/download/v1.1.0/subjs_1.1.0_linux_amd64.tar.gz
# tar -xvf subjs_1.1.0_linux_amd64.tar.gz
# sudo mv subjs /usr/local/bin/subjs

# Katana
# echo "Katana: https://github.com/projectdiscovery/katana/releases"
# wget https://github.com/projectdiscovery/katana/releases/download/v1.0.4/katana-linux-amd64.zip
# unzip katana-linux-amd64.zip
# chmod +x katana
# sudo mv katana /usr/local/bin/katana


echo "Installation script finished."
echo "Please ensure you have installed the manual tools listed above."
