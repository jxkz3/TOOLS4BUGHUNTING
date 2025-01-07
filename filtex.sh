#!/bin/bash

# Define file and directory variables
ENDPOINTS_FILE="endpoints.txt"
RESULT_DIR="Furl"

# Create Furl directory if it does not exist
mkdir -p $RESULT_DIR

# Check if endpoints file exists and is not empty
if [ ! -s $ENDPOINTS_FILE ]; then
    echo "Error: $ENDPOINTS_FILE is empty or does not exist."
    exit 1
fi

# Ensure grep is available
if ! command -v grep &> /dev/null; then
    echo "Error: grep is not installed. Please install grep and try again."
    exit 1
fi

# Define regex patterns for various filters
RCE_PATTERNS='\?cmd=|\?exec=|\?command=|\?execute=|\?ping=|\?query=|\?jump=|\?code=|\?reg=|\?do=|\?func=|\?arg=|\?option=|\?load=|\?process=|\?step=|\?read=|\?function=|\?req=|\?feature=|\?exe=|\?module=|\?payload=|\?run=|\?print=|\?shell=|\?debug='
SSRF_PATTERNS='\?dest=|\?redirect=|\?uri=|\?path=|\?continue=|\?url=|\?window=|\?next=|\?data=|\?reference=|\?site=|\?html=|\?val=|\?validate=|\?domain=|\?callback=|\?return=|\?page=|\?feed=|\?host=|\?port=|\?to=|\?out=|\?view=|\?dir=|\?remote=|\?fetch='
LFI_PATTERNS='\?cat=|\?dir=|\?action=|\?board=|\?date=|\?detail=|\?file=|\?download=|\?path=|\?folder=|\?prefix=|\?include=|\?page=|\?inc=|\?locate=|\?show=|\?doc=|\?site=|\?type=|\?view=|\?content=|\?document=|\?layout=|\?mod=|\?conf=|\?open=|\?source=|\?template=|\?view_file=|\?load=|\?read=|\?theme=|\?route=|\?index=|\?language=|\?content=|\?pg=|\?download_file=|\?controller=|\?image=|\?lib=|\?start=|\?style=|\?attachment=|\?asset=|\?main=|\?config='
SQLI_PATTERNS='\?id=|\?page=|\?dir=|\?search=|\?category=|\?file=|\?class=|\?url=|\?news=|\?item=|\?menu=|\?lang=|\?name=|\?ref=|\?title=|\?view=|\?topic=|\?thread=|\?type=|\?date=|\?form=|\?join=|\?main=|\?nav=|\?region=|\?order=|\?filter=|\?info='
XSS_PATTERNS='\?q=|\?s=|\?search=|\?id=|\?lang=|\?keyword=|\?query=|\?page=|\?keywords=|\?year=|\?view=|\?email=|\?type=|\?name=|\?p=|\?month=|\?image=|\?list_type=|\?url=|\?terms=|\?categoryid=|\?key=|\?login=|\?begindate=|\?enddate=|\?message=|\?content='
IMAGE_EXTENSIONS='\.(jpg|jpeg|png|bmp|tiff|svg|webp)$'
WEB_EXTENSIONS='\.(jsp|jspx|asp|aspx|do|mi|action|php|html|htm|cfm|py|rb|pl|cgi)$'
DOC_EXTENSIONS='\.(pdf|doc|docx|xls|xlsx|ppt|pptx|odt|ods|odp|rtf)$'
XML_JSON_EXTENSIONS='\.(xml|json)$'
DEPRECATED_PATTERNS='\?old=|\?legacy=|\?deprecated=|\?obsolete=|\?outdated=|\?archive=|\?backup=|\?unused=|\?unsupported=|\?retired=|\?previous='
SENSITIVE_INFO_PATTERNS='email=|phone=|password=|secret=|token=|api_key=|auth=|credit_card=|ssn=|dob=|address=|pin=|social=|account_number=|login_password='
KEYWORD_PATTERNS='preferences|notifications|unsubscribe|validate|invoice|billing|order|tracking|guest|login|register|signup|account|user|profile|security|payment|subscription|confirm|activate|reset|recover|access|feedback|report|support|admin|details|update|settings|config|setup|change|modify|history'
# Define regex patterns for OS Command Injection
OS_COMMAND_INJECTION_PATTERNS='\?cmd=|\?exec=|\?command=|\?execute=|\?ping=|\?query=|\?jump=|\?code=|\?reg=|\?do=|\?func=|\?arg=|\?option=|\?load=|\?process=|\?step=|\?read=|\?function=|\?req=|\?feature=|\?exe=|\?module=|\?payload=|\?run=|\?print='
# Filter various file extensions for info disclosure
INFO_DISCLOSURE_EXTENSIONS='\.(xls|xlsx|pdf|sql|doc|docx|pptx|txt|zip|tar\.gz|tgz|bak|7z|rar|log|cache|secret|db|backup|yml|gz|config|csv|yaml|md|md5|tar|xz|7zip|p12|pem|key|crt|csr|sh|pl|py|java|class|jar|war|ear|sqlitedb|db|sqlite3|dbf|db3|accdb|mdb|sqlcipher|gitignore|env|ini|conf|properties|plist|cfg|passwd|shadow|htpasswd|kdbx|ovpn|rdp|log1|log2|bz2|lz|lzma|Z|old|save)$'



# Filter Remote Code Execution (RCE) parameters
grep -E "$RCE_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-rce.txt

# Filter Server-Side Request Forgery (SSRF) parameters
grep -E "$SSRF_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-ssrf.txt

# Filter Local File Inclusion (LFI) parameters
grep -E "$LFI_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-lfi.txt

# Filter SQL Injection (SQLi) parameters
grep -E "$SQLI_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-sqli.txt

# Filter Cross-Site Scripting (XSS) parameters
grep -E "$XSS_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-xss.txt

# Filter specific file extensions (images)
grep -E "$IMAGE_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-images.txt

# Filter Open Redirect (OPRI) parameters
grep -E '\?next=|\?url=|\?target=|\?rurl=|\?dest=|\?destination=|\?redir=|\?redirect_uri=|\?redirect_url=|\?redirect=|/redirect/|/cgi-bin/redirect.cgi?|\?out=|\?view=|\?login?to=|\?image_url=|\?go=|\?return=|\?returnTo=|\?return_to=|\?checkout_url=|\?continue=|\?return_path=' $ENDPOINTS_FILE > $RESULT_DIR/Furl-opri.txt

# Filter email domains (plain and URL-encoded)
grep -E '@gmail.com|@outlook.com|@hotmail.com|@custom.com|@yahoo.com|@aol.com|@icloud.com|@mail.com|@live.com|@mail.ru|@zoho.com|@gmx.com|@yandex.com|@protonmail.com|@tutanota.com|%40gmail.com|%40outlook.com|%40hotmail.com|%40custom.com|%40yahoo.com|%40aol.com|%40icloud.com|%40mail.com|%40live.com|%40mail.ru|%40zoho.com|%40gmx.com|%40yandex.com|%40protonmail.com|%40tutanota.com' $ENDPOINTS_FILE > $RESULT_DIR/Furl-emails.txt

# Filter sensitive information parameters
grep -E "$SENSITIVE_INFO_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-sensitive-info.txt

# Filter specific keywords
grep -E "$KEYWORD_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-keywords.txt

# Filter various web file extensions
grep -E "$WEB_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-web-extensions.txt

# Filter specific file extensions (PDF and similar)
grep -E "$DOC_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-docs.txt

# Filter XML and JSON file extensions
grep -E "$XML_JSON_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-xml-json.txt

# Filter deprecated parameters
grep -E "$DEPRECATED_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-deprecated.txt

# Filter JavaScript files (URLs and paths)
cat $ENDPOINTS_FILE | grep -oE 'https?://[^ ]+\.js|/[^ ]+\.js' > $RESULT_DIR/jsfiles.txt

# Filter OS Command Injection parameters
grep -E "$OS_COMMAND_INJECTION_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-oscommand-injection.txt

# Filter various file extensions
grep -E "$INFO_DISCLOSURE_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/Furl-info-disclosure.txt


echo "All filtering operations completed."
