#!/bin/bash


echo "**********************************************************************************************"
echo "--------------------------Cyb3rGotH's Recon Script For Bug Bounty----------------------------"
echo "**********************************************************************************************"


function show_methods() {
		echo " ----------------------------------- "
		echo "Recon methods are as follows -----"
		echo "1. Subdomain Enumeration"
		echo "2. Sorting Subdomains"
		echo "3. Checking for live subdomains"
		echo "4. Finding JS links"
		echo "5. Finding URLs from subdomains"
		echo "6. Vulnerability scanning"
		echo "7. Taking screenshots"
		echo "8. Subdomain Takeover"
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



# Getting github API key for subdomain enumeration
read -p "Do you have a Github API key? (y/n): " choice2
if [[ $choice2 -eq "y" ]]; then
	echo "No need to configure it"
else 
		echo "Please provide your Github API key"
		read -p "Enter your Github API key here: " github_key
fi


# Getting chaos API key for subdomain enumeration
read -p "Do you have Chaos API key? (y/n): " choice3
if [[ $choice3 -eq "y" ]]; then
	echo "No need to configure it"
else 
		echo "Please provide your Chaos API key"
		read -p "Enter your Chaos API key here: " chaos_key
fi


# Subdomain Enumeration 
mkdir -p "$Base_domain/subdomains"

echo "Commencing Subdomain Enumeration .............."
assetfinder $target -subs-only >> $Base_domain/subdomains/assetfinder.txt
subfinder -d $target >> $Base_domain/subdomains/subfinder.txt
findomain -t $target >> $Base_domain/subdomains/findomain.txt

export GITHUB_TOKEN=$github_key
github-subdomains -d $target >> Base_domain/subdomains/github-subs.txt

export CHAOS_KEY=$chaos_key
chaos -d $target >> $Base_domain/subdomains/chaos.txt


# Sorting subdomains 
echo "Combining and deduplicating subdomains ............"
cat $Base_domain/subdomains/*.txt | sort -u >> $Base_domain/subdomains/all-subs.txt 


# Finding live subdomains 
echo "Checking for live subdomains .............."
cat $Base_domain/subdomains/all-subs.txt | httpx-toolkit >> $Base_domain/subdomains/httpx.txt
cat $Base_domain/subdomains/all-subs.txt | httprobe >> $Base_domain/subdomains/httprobe.txt
echo "Sorting live subdomains....."
cat $Base_domain/subdomains/httpx.txt $Base_domain/subdomains/httprobe.txt | sort | uniq > $Base_domain/subdomains/live.txt



# Taking screenshots of live subdomains
mkdir -p "$Base_domain/screenshots"
echo "Taking screenshots usinf Aquatone............"
cat $Base_domain/subdomains/live.txt | aquatone -out $Base_domain/screenshots/


# Vulnerability Scanning 
mkdir -p "$Base_domain/vulnerability_scan"
echo "Vulnerability scanning with Nuclei.............."
nuclei -l $Base_domain/subdomains/live.txt > $Base_domain/vulnerability_scan/nuclei.txt



# Subdomain Takeover 
mkdir -p "$Base_domain/subdomain_takeover"
echo "Searching for Subdomain takeover with Subzy and Subjack............."
subzy run --targets $Base_domain/subdomains/live.txt >> $Base_domain/subdomain_takeover/subzy.txt
subjack -w $Base_domain/subdomains/live.txt  -timeout 30 -t 100 -v >> $Base_domain/subdomain_takeover/subjack.txt



# Broken Link Hijacking
mkdir -p "$Base_domain/broken_links"
echo "Finding broken links using SocialHunter..........."
socialhunter -f $Base_domain/subdomains/live.txt >> $Base_domain/broken_links/social.txt




# Finding JS Links
mkdir -p "$Base_domain/js_links"
echo "Finding JS links with Subjs and Katana..........."
cat $Base_domain/subdomains/live.txt | subjs >> $Base_domain/js_links/subjs.txt
cat $Base_domain/subdomains/live.txt | katana >> $Base_domain/js_links/katana.txt





# Findind URLs for subdomains 
mkdir -p "$Base_domain/urls"
echo "Finding URLs from subdomains using WayBackUrls......."
cat $Base_domain/subdomains/all-subs.txt | waybackurls >> $Base_domain/urls/waybackurls.txt


echo "All the tasks has been completed and the files have been saved in the respective directories .."
echo "*********Happy Hunting********"











































