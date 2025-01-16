# Filtex: Web Application Security Filtering Tool

**Filtex** is a suite of bash scripts designed to filter parameters, file extensions, and keywords from web application endpoints, aiding security assessments and bug bounty programs. It detects potential vulnerabilities such as RCE, SSRF, LFI, SQLi, XSS, and open redirects, and identifies sensitive information and specific file types (e.g., images, documents, XML, JSON). The tool is essential for filtering out various security risks, deprecated parameters, and email domains.

## Usage
1. Clone: 
    ```bash
    git clone https://github.com/jxkz3/filtex.git
    ```
2. Navigate:
    ```bash
    cd filtex
    ```
3. Make executable:
    ```bash
    chmod +x filtex.sh
    ```
4. Run:
    ```bash
    ./filtex.sh -f customfile.txt
    ```



----
# drklink.sh
drklink.sh is a bash script that generates GitHub search URLs to find sensitive data (like API keys, passwords, and secrets) in an organization's repositories. It takes the organization's name as an argument and searches for predefined security-related keywords, outputting the relevant GitHub search links.


# deduxv2
This script processes a list of URLs (from cleaned_urls.txt), extracting the path and query parameters. It tracks the most specific URL for each unique combination of path and parameter, based on lexicographical comparison. The script outputs the cleaned URLs with the most specific matches into clean.txt.
