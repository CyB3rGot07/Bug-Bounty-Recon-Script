*Cyb3rGotH's Bug Bounty Recon Script*

BB-Recon is a bash script designed for comprehensive domain and subdomain enumeration, scanning, and analysis. This script integrates multiple tools to discover subdomains, analyze their attack surface, and gather additional information about target domains.This consists of multiple tools adapted from methodologies of many popular and skilled Bug Bounty Hunters. 

Tools Used

The script incorporates the following tools:

    Assetfinder: Finds subdomains by querying public sources.
    Subfinder: Fast subdomain discovery tool.
    Findomain: Finds subdomains through various sources.
    GitHub Subdomains: Extracts subdomains from GitHub repositories.
    Chaos Client: Fetches subdomains from the Chaos database.
    httpx: Performs HTTP probing and banner grabbing.
    httprobe: Checks if URLs are live.
    Aquatone: Visualizes and analyzes subdomains with screenshots.
    Nuclei: Runs customizable vulnerability scans.
    Subzy: Discovers subdomains and performs additional checks.
    Subjack: Identifies and verifies subdomain takeover vulnerabilities.
    SocialHunter: Finds subdomains based on social media data.
    SubJS: Enumerates subdomains by analyzing JavaScript files.
    Katana: Fast and flexible HTTP/2-enabled URL discovery tool.
    Waybackurls: Extracts URLs from archived web snapshots.

Prerequisites

Ensure that you have the following tools installed on your system:

    Assetfinder
    Subfinder
    Findomain
    GitHub Subdomains
    Chaos Client
    httpx
    httprobe
    Aquatone
    Nuclei
    Subzy
    Subjack
    SocialHunter
    SubJS
    Katana
    Waybackurls

Refer to each tool's documentation for installation instructions. Most tools can be installed using package managers or from their respective GitHub repositories.
Usage

    Clone the Repository:

    sh

git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name

Prepare Your Input File:

Create a domains.txt file with one domain per line. This file will be used as input for the script.

Make the Script Executable:

sh

chmod +x BB-Recon.sh

Run the Script:

sh

    ./BB-Recon.sh

    The script performs the following tasks:
        Enumerates subdomains using various tools.
        Probes HTTP endpoints and checks their availability.
        Captures screenshots of discovered subdomains.
        Runs vulnerability scans.
        Saves results to the output directory.

    View Results:

    After the script completes, check the output directory for results. Each tool's output will be saved in separate files within this directory.

Configuration

You may need to adjust paths and tool options based on your environment:

    Aquatone: Ensure the CHROMIUM_PATH environment variable is set if required.
    Nuclei: Update the path to Nuclei templates in the script.
    Subjack: Provide the correct path to the subjack fingerprints file.

Modify BB-Recon.sh to fit your specific needs or to include additional tools and configurations.
Contributing

Contributions are welcome! If you encounter issues or have suggestions for improvements, please open an issue or submit a pull request.
License

This project is licensed under the MIT License. See the LICENSE file for details.
Disclaimer

This script is intended for educational and security testing purposes only. Always obtain proper authorization before scanning or testing any systems or networks.
