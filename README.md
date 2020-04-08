# crt-grabber
Subdomain finder tool

## Usage
./crt-grabber.sh target.com

## Dependencies
- [crt.sh](https://crt.sh/)
- [BASH](https://www.linux.org/pages/download/)
- [curl](https://curl.haxx.se/download.html)
- [jq](https://stedolan.github.io/jq/)

## About
This tool is written in bash. It gathers all the subdomains of a domain by looking for dns certificates on crt.sh. It downloads a json file containing names and details of subdomains genrated from crt.sh and parses it into a presentable form.


## Reference 
1. [crtndstry](https://github.com/nahamsec/crtndstry)

## Target Audience 
Web Application Security Researchers
