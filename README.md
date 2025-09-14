# BB-Recon.sh - Bug Bounty Recon Script

**BB-Recon.sh** is a comprehensive bash script designed to automate the reconnaissance process for bug bounty hunting. It chains together a variety of tools to provide a thorough initial scan of a target domain. This consists of tools and methodologies used by many popular and skilled Bug Bounty Hunters.

## Features

This script automates the following recon tasks:

-   **Subdomain Enumeration**: Gathers subdomains from various sources.
-   **Live Subdomain Discovery**: Checks which subdomains are live and responding.
-   **Port Scanning**: Scans live subdomains for open ports.
-   **Web Screenshotting**: Takes screenshots of live web services.
-   **URL Discovery**: Fetches URLs from various sources like Wayback Machine.
-   **Content Discovery**: Fuzzes for hidden files and directories.
-   **JavaScript Analysis**: Extracts links and secrets from JavaScript files.
-   **Parameter Discovery**: Finds URL parameters for further testing.
-   **Vulnerability Scanning**: Runs nuclei and dalfox for initial vulnerability checks.
-   **Subdomain Takeover Scans**: Checks for potential subdomain takeovers.
-   **Broken Link Hijacking**: Looks for broken social media links.
-   **Reporting**: Generates consolidated reports in both `.txt` and beautified `.html` formats.

## Tools Used

The script utilizes the following tools:

-   **Subdomain Enumeration**: `assetfinder`, `subfinder`, `findomain`, `github-subdomains`, `chaos`, `amass`
-   **Live Probing**: `httpx-toolkit`, `httprobe`
-   **Port Scanning**: `naabu`
-   **Screenshots**: `aquatone`
-   **URL Fetching**: `waybackurls`, `gau`
-   **Content Discovery**: `ffuf`
-   **JS Analysis**: `subjs`, `katana`, `linkfinder`
-   **Parameter Discovery**: `paramspider`
-   **Vulnerability Scanning**: `nuclei`, `dalfox`
-   **Subdomain Takeover**: `subzy`, `subjack`
-   **Broken Link Hijacking**: `socialhunter`

## Installation

1.  **Prerequisites**:
    *   **Go**: Make sure you have Go installed on your system (`go version`).
    *   **Python**: Make sure you have Python 3 and pip installed (`python3 --version`, `pip3 --version`).

2.  **Clone the Repository**:
    ```bash
    git clone https://github.com/CyB3rGoT07/Bug-Bounty-Recon-Script.git
    cd Bug-Bounty-Recon-Script
    ```

3.  **Install Tools**:
    A helper script `install.sh` is provided to install most of the required tools.
    ```bash
    chmod +x install.sh
    ./install.sh
    ```
    This script will install all Go-based tools and Python dependencies. However, some tools need to be installed manually. Please see the "Manual Tool Installation" section below.

4.  **Make the Script Executable**:
    ```bash
    chmod +x BB-Recon.sh
    ```

## Manual Tool Installation

Some tools are not installed by the `install.sh` script and require manual installation. These are listed below with their installation instructions. Please ensure you download the correct binary for your system architecture.

### Findomain
```bash
# Visit https://github.com/findomain/findomain/releases
wget https://github.com/findomain/findomain/releases/download/8.2.1/findomain-linux.zip
unzip findomain-linux.zip
chmod +x findomain
sudo mv findomain /usr/local/bin/findomain
```

### Aquatone
```bash
# Visit https://github.com/michenriksen/aquatone/releases
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone_linux_amd64_1.7.0.zip
sudo mv aquatone /usr/local/bin/
```

### Subzy
```bash
# Visit https://github.com/lc/subzy/releases
wget https://github.com/L-C/subzy/releases/download/v1.0.2/subzy_1.0.2_linux_amd64.tar.gz
tar -xvf subzy_1.0.2_linux_amd64.tar.gz
sudo mv subzy /usr/local/bin/subzy
```

### Subjack
```bash
# Visit https://github.com/haccer/subjack/releases
wget https://github.com/haccer/subjack/releases/download/v1.3.1/subjack_1.3.1_linux_amd64.tar.gz
tar -xvf subjack_1.3.1_linux_amd64.tar.gz
sudo mv subjack /usr/local/bin/subjack
```

### SocialHunter (Sublist3r)
This tool is for finding social media links.
```bash
# Visit https://github.com/aboul3la/Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r
pip install -r requirements.txt
cd ..
```

### SubJS
```bash
# Visit https://github.com/lc/subjs/releases
wget https://github.com/lc/subjs/releases/download/v1.1.0/subjs_1.1.0_linux_amd64.tar.gz
tar -xvf subjs_1.1.0_linux_amd64.tar.gz
sudo mv subjs /usr/local/bin/subjs
```

### Katana
```bash
# Visit https://github.com/projectdiscovery/katana/releases
wget https://github.com/projectdiscovery/katana/releases/download/v1.0.4/katana-linux-amd64.zip
unzip katana-linux-amd64.zip
chmod +x katana
sudo mv katana /usr/local/bin/katana
```

## Usage

Run the script with:
```bash
./BB-Recon.sh
```
The script will then prompt you for:
-   The target domain.
-   API keys for Github and Chaos if they are not set as environment variables.
-   The path to your wordlist for `ffuf`.
-   The path to your `linkfinder.py` script.

### Automated Usage

For non-interactive, automated use, you can set the following environment variables before running the script:

-   `GITHUB_TOKEN`: Your Github API key.
-   `CHAOS_KEY`: Your Chaos API key.
-   `WORDLIST`: The absolute path to your wordlist for `ffuf`.
-   `LINKFINDER_PATH`: The absolute path to your `linkfinder.py` script.

**Example:**
```bash
export GITHUB_TOKEN="your_github_token"
export CHAOS_KEY="your_chaos_key"
export WORDLIST="/path/to/your/wordlist.txt"
export LINKFINDER_PATH="/path/to/LinkFinder/linkfinder.py"
./BB-Recon.sh
```
*Note: The script will still ask for the target domain.*

## Reporting

After the script finishes, it will generate a results directory named after the target domain (e.g., `example`). Inside this directory, you will find:

-   Subdirectories for each tool's raw output.
-   A consolidated `report.txt` file with all the findings.
-   A beautified `report.html` file with collapsible sections for easy navigation. Open this file in your browser to view the report.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Disclaimer

This script is intended for educational and security testing purposes only. Always obtain proper authorization before scanning or testing any systems or networks.
