Bug Bounty Recon Script

Bug Bounty Recon Script is a comprehensive bash script developed to automate domain and subdomain enumeration, scanning, and analysis. This script integrates multiple powerful tools to help you discover subdomains, analyze their attack surface, and gather valuable information about target domains efficiently.
Tools Used

The script utilizes the following tools:

    Assetfinder: Finds subdomains by querying public sources.
    Subfinder: Fast and reliable subdomain discovery tool.
    Findomain: Finds subdomains through various sources.
    GitHub Subdomains: Extracts subdomains from GitHub repositories.
    Chaos Client: Fetches subdomains from the Chaos database.
    httpx: Performs HTTP probing and banner grabbing.
    httprobe: Checks if URLs are live.
    Aquatone: Provides screenshots and analysis of discovered subdomains.
    Nuclei: Runs customizable vulnerability scans on targets.
    Subzy: Discovers subdomains and performs additional checks.
    Subjack: Identifies and verifies subdomain takeover vulnerabilities.
    SocialHunter: Finds subdomains based on social media data.
    SubJS: Enumerates subdomains by analyzing JavaScript files.
    Katana: Fast and flexible HTTP/2-enabled URL discovery tool.
    Waybackurls: Extracts URLs from archived web snapshots.

Prerequisites

Ensure you have the following tools installed on your system:

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

Refer to the tools' documentation for installation instructions. Most can be installed using package managers or from their respective GitHub repositories.
Installation

    Clone the Repository:

    sh

git clone https://github.com/CyB3rGoT07/Bug-Bounty-Recon-Script.git
cd Bug-Bounty-Recon-Script

Install Dependencies:

Follow the installation instructions provided in the requirements.txt file to set up the necessary tools.

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
        Saves all results to the output directory.

    View Results:

    After the script completes, review the output directory for results. Each tool's output will be saved in separate files within this directory.

Configuration

You might need to configure certain aspects based on your environment:

    Aquatone: Ensure the CHROMIUM_PATH environment variable is set if required.
    Nuclei: Update the path to Nuclei templates in the script.
    Subjack: Provide the correct path to the subjack fingerprints file.

Feel free to modify BB-Recon.sh to fit your specific needs or to include additional tools and configurations.
Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.
License

This project is licensed under the MIT License. See the LICENSE file for details.
Disclaimer

This script is intended for educational and security testing purposes only. Always obtain proper authorization before scanning or testing any systems or networks
