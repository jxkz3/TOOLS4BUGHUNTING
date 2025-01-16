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

## License
MIT License.
