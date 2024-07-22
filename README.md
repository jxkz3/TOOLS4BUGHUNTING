# Filtex

# Filtex: Web Application Security Filtering Tool

**Filtex** is a suite of bash scripts designed to filter various parameters, file extensions, and keywords from web application endpoints. These tools are essential for security assessments and bug bounty programs, helping identify potential vulnerabilities and sensitive information.

## Included Filters

- **RCE (Remote Code Execution) Parameter Filter:** Detects parameters in endpoints that could be exploited for Remote Code Execution attacks.

- **SSRF (Server-Side Request Forgery) Parameter Filter:** Identifies parameters that might be vulnerable to Server-Side Request Forgery attacks.

- **LFI (Local File Inclusion) Parameter Filter:** Filters parameters susceptible to Local File Inclusion vulnerabilities.

- **SQLi (SQL Injection) Parameter Filter:** Finds parameters that may be vulnerable to SQL Injection attacks.

- **XSS (Cross-Site Scripting) Parameter Filter:** Filters parameters that could be exploited for Cross-Site Scripting attacks.

- **Image File Extensions Filter:** Detects endpoints serving image file extensions.

- **Open Redirect (OPRI) Parameter Filter:** Identifies parameters that may lead to Open Redirect vulnerabilities.

- **Email Domains Filter:** Filters out email domains from common providers.

- **Sensitive Information Parameters Filter:** Detects parameters that may expose sensitive information.

- **Keywords Filter:** Searches for endpoints containing specific keywords related to security and user information.

- **Web File Extensions Filter:** Identifies various web file extensions in endpoints.

- **Document File Extensions Filter:** Filters endpoints serving document file types.

- **XML and JSON File Extensions Filter:** Detects endpoints serving XML and JSON file types.

- **Deprecated Parameters Filter:** Identifies parameters that are outdated or deprecated.

## Usage

1. Clone the repository to your local machine:
    ```bash
    git clone https://github.com/jxkz3/filtex.git
    ```

2. Navigate to the directory containing the script:
    ```bash
    cd filtex
    ```

3. Make the script executable:
    ```bash
    chmo
