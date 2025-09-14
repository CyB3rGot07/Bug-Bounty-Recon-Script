#!/bin/bash

# For automated use, you can set the following environment variables:
# GITHUB_TOKEN: Your Github API key
# CHAOS_KEY: Your Chaos API key
# WORDLIST: Path to your wordlist for ffuf
# LINKFINDER_PATH: Path to your linkfinder.py script


echo "**********************************************************************************************"
echo "--------------------------Cyb3rGotH's Recon Script For Bug Bounty----------------------------"
echo "**********************************************************************************************"


function show_methods() {
		echo " ----------------------------------- "
		echo "Recon methods are as follows -----"
		echo "1. Subdomain Enumeration (assetfinder, subfinder, findomain, github, chaos, amass)"
		echo "2. Finding Live Subdomains & Port Scanning (httpx, naabu)"
		echo "3. Screenshotting Live Subdomains (aquatone)"
		echo "4. URL Discovery from all subdomains (waybackurls, gau)"
		echo "5. Content Discovery on live domains (ffuf)"
		echo "6. Javascript Analysis (subjs, katana, linkfinder)"
		echo "7. Parameter Discovery (paramspider)"
		echo "8. Vulnerability Scanning (nuclei, dalfox)"
		echo "9. Subdomain Takeover (subzy, subjack)"
		echo "10. Broken Link Hijacking (socialhunter)"
		echo " ----------------------------------- " 
		read -p "Do you want to proceed with these methods? (y/n): " choice1
		if [[ "$choice1" = "n" ]]; then
			echo "*******Aborting Script *******"
			exit 1
		fi
}


show_methods


read -p "Please Enter a URL: " target 

# Creating parent directory
Base_domain=$(echo $target | awk -F'.' '{print$1}')

mkdir -p "$Base_domain"
echo "Directory '$Base_domain' has been created"



# Getting API keys
echo "Checking for API keys ............"
if [[ -z "$GITHUB_TOKEN" ]]; then
	read -p "Please provide your Github API key: " GITHUB_TOKEN
	export GITHUB_TOKEN
else
	echo "Github API key found"
fi


if [[ -z "$CHAOS_KEY" ]]; then
	read -p "Please provide your Chaos API key: " CHAOS_KEY
	export CHAOS_KEY
else
	echo "Chaos API key found"
fi


# 1. Subdomain Enumeration
mkdir -p "$Base_domain/subdomains"

echo "Commencing Subdomain Enumeration .............."
assetfinder $target -subs-only >> "$Base_domain/subdomains/assetfinder.txt"
subfinder -d $target >> "$Base_domain/subdomains/subfinder.txt"
findomain -t $target >> "$Base_domain/subdomains/findomain.txt"
github-subdomains -d $target >> "$Base_domain/subdomains/github-subs.txt"
chaos -d $target >> "$Base_domain/subdomains/chaos.txt"
amass enum -d $target >> "$Base_domain/subdomains/amass.txt"

echo "Combining and deduplicating subdomains ............"
cat "$Base_domain"/subdomains/*.txt | sort -u >> "$Base_domain/subdomains/all-subs.txt"


# 2. Finding live subdomains & Port Scanning
echo "Checking for live subdomains .............."
cat "$Base_domain/subdomains/all-subs.txt" | httpx-toolkit >> "$Base_domain/subdomains/httpx.txt"
cat "$Base_domain/subdomains/all-subs.txt" | httprobe >> "$Base_domain/subdomains/httprobe.txt"
echo "Sorting live subdomains....."
cat "$Base_domain/subdomains/httpx.txt" "$Base_domain/subdomains/httprobe.txt" | sort | uniq > "$Base_domain/subdomains/live.txt"

mkdir -p "$Base_domain/port_scanning"
echo "Scanning for open ports with Naabu.............."
naabu -l "$Base_domain/subdomains/live.txt" -o "$Base_domain/port_scanning/naabu.txt"


# 3. Taking screenshots of live subdomains
mkdir -p "$Base_domain/screenshots"
echo "Taking screenshots usinf Aquatone............"
cat "$Base_domain/subdomains/live.txt" | aquatone -out "$Base_domain/screenshots/"


# 4. Finding URLs for subdomains
mkdir -p "$Base_domain/urls"
echo "Finding URLs from subdomains using WayBackUrls and Gau......."
cat "$Base_domain/subdomains/all-subs.txt" | waybackurls >> "$Base_domain/urls/waybackurls.txt"
cat "$Base_domain/subdomains/all-subs.txt" | gau >> "$Base_domain/urls/gau.txt"
echo "Combining and deduplicating URLs ............"
cat "$Base_domain"/urls/*.txt | sort -u >> "$Base_domain/urls/all-urls.txt"


# 5. Content Discovery
mkdir -p "$Base_domain/content_discovery"
echo "Starting content discovery with ffuf. This may take a long time."
read -p "Please provide the path to your wordlist for content discovery (ffuf): " wordlist
if [[ ! -f "$wordlist" ]]; then
    echo "Wordlist not found! Skipping content discovery."
else
    for domain in $(cat "$Base_domain/subdomains/live.txt"); do
        sanitized_domain=$(echo $domain | sed 's|https://||g' | sed 's|http://||g' | sed 's|:|_|g')
        echo "Running ffuf on $domain"
        ffuf -w "$wordlist" -u "$domain/FUZZ" -o "$Base_domain/content_discovery/$sanitized_domain.json" -of json
    done
fi


# 6. Finding JS Links and Secrets
mkdir -p "$Base_domain/js_links"
echo "Finding JS links with Subjs and Katana..........."
cat "$Base_domain/subdomains/live.txt" | subjs >> "$Base_domain/js_links/subjs.txt"
cat "$Base_domain/subdomains/live.txt" | katana >> "$Base_domain/js_links/katana.txt"
cat "$Base_domain/js_links/subjs.txt" "$Base_domain/js_links/katana.txt" | sort -u > "$Base_domain/js_links/all_js_links.txt"

echo "Downloading JS files..........."
mkdir -p "$Base_domain/js_links/files"
while read url; do
    filename=$(echo "$url" | sed 's|https://||g' | sed 's|http://||g' | sed 's|/|_|g')
    wget -q -O "$Base_domain/js_links/files/$filename.js" "$url"
done < "$Base_domain/js_links/all_js_links.txt"

echo "Running Linkfinder on JS files..........."
read -p "Please provide the path to your linkfinder.py script: " linkfinder_path
if [[ ! -f "$linkfinder_path" ]]; then
    echo "linkfinder.py not found! Skipping."
else
    python "$linkfinder_path" -i "$Base_domain/js_links/files/*.js" -o cli >> "$Base_domain/js_links/linkfinder_output.txt"
fi


# 7. Parameter Discovery
mkdir -p "$Base_domain/param_discovery"
echo "Discovering parameters with Paramspider.............."
paramspider -l "$Base_domain/urls/all-urls.txt" --output "$Base_domain/param_discovery/params.txt"


# 8. Vulnerability Scanning
mkdir -p "$Base_domain/vulnerability_scan"
echo "Vulnerability scanning with Nuclei.............."
nuclei -l "$Base_domain/subdomains/live.txt" -o "$Base_domain/vulnerability_scan/nuclei.txt"

echo "Scanning for XSS with Dalfox.............."
dalfox file "$Base_domain/urls/all-urls.txt" -o "$Base_domain/vulnerability_scan/dalfox.txt"


# 9. Subdomain Takeover
mkdir -p "$Base_domain/subdomain_takeover"
echo "Searching for Subdomain takeover with Subzy and Subjack............."
subzy run --targets "$Base_domain/subdomains/live.txt" >> "$Base_domain/subdomain_takeover/subzy.txt"
subjack -w "$Base_domain/subdomains/live.txt"  -timeout 30 -t 100 -v >> "$Base_domain/subdomain_takeover/subjack.txt"


# 10. Broken Link Hijacking
mkdir -p "$Base_domain/broken_links"
echo "Finding broken links using SocialHunter..........."
socialhunter -f "$Base_domain/subdomains/live.txt" >> "$Base_domain/broken_links/social.txt"


# Generate reports
echo "Generating reports..........."
python3 generate_report.py "$Base_domain"

echo "All the tasks has been completed and the files have been saved in the respective directories .."
echo "*********Happy Hunting********"
