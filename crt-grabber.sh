if [[ $# -ne 1 ]]; then
	echo "Usage: ./crt-grabber.sh <domain>"
	echo "Example: ./crt-grabber.sh target.com"
	exit 1
fi

if [ ! -d "recon" ]; then
	mkdir recon
fi

certdata(){
	echo "$(tput setaf 226)[+] Looking for subdomains on crt.sh"
	curl -s https://crt.sh/\?q\=$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u > recon/$1-crtsh.txt
	echo "[+] Done"
	
}


rootdomains() {
	cat recon/$1-crtsh.txt | rev | cut -d "."  -f 1,2,3 | sort -u | rev > ./recon/$1-temp2.txt
	echo "$(tput setaf 160)[+] Number of results found: $(cat recon/$1-temp2.txt | wc -l)"
	echo "[+] Filtering valid domains"
	sub='@'; sub2='\\'; touch recon/$1-$(date "+%Y.%m.%d-%H.%M").txt
	for i in $(cat recon/$1-temp2.txt);
	do
		if grep -q "$sub" <<< "$i" || grep -q "$sub2" <<< "$i"; then
			:
		else
			echo "$(tput setaf 46)$i"
			echo "$i" >> recon/$1-$(date "+%Y.%m.%d-%H.%M").txt
		fi
	done
	echo "$(tput setaf 160)[+] Valid domains found: $(cat recon/$1-$(date "+%Y.%m.%d-%H.%M").txt | wc -l) "
	rm -rf recon/$1-crtsh.txt; rm -rf recon/$1-temp2.txt
}


certdata $1
rootdomains $1

echo "[+] Retrieved data saved in: recon/$1-$(date "+%Y.%m.%d-%H.%M").txt"
