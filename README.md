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
    The `requirements.txt` file contains the installation instructions for all the tools used in this script. Go through the file and install the required tools. Many are Go-based, so ensure your Go environment (`$GOPATH`, `$GOROOT`) is set up correctly.

4.  **Make the Script Executable**:
    ```bash
    chmod +x BB-Recon.sh
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
