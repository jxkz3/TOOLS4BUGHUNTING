#!/bin/bash

ENDPOINTS_FILE="endpoints.txt"
RESULT_DIR="filtex-results"

# Create results directory if it does not exist
mkdir -p $RESULT_DIR

# Check if file exists and is not empty
if [ ! -s $ENDPOINTS_FILE ]; then
    echo "Error: $ENDPOINTS_FILE is empty or does not exist."
    exit 1
fi

# Define patterns
RCE_PATTERNS='\?cmd=|\?exec=|\?command=|\?execute=|\?ping=|\?query=|\?jump=|\?code=|\?reg=|\?do=|\?func=|\?arg=|\?option=|\?load=|\?process=|\?step=|\?read=|\?function=|\?req=|\?feature=|\?exe=|\?module=|\?payload=|\?run=|\?print='
SSRF_PATTERNS='\?dest=|\?redirect=|\?uri=|\?path=|\?continue=|\?url=|\?window=|\?next=|\?data=|\?reference=|\?site=|\?html=|\?val=|\?validate=|\?domain=|\?callback=|\?return=|\?page=|\?feed=|\?host=|\?port=|\?to=|\?out=|\?view=|\?dir='
LFI_PATTERNS='\?cat=|\?dir=|\?action=|\?board=|\?date=|\?detail=|\?file=|\?download=|\?path=|\?folder=|\?prefix=|\?include=|\?page=|\?inc=|\?locate=|\?show=|\?doc=|\?site=|\?type=|\?view=|\?content=|\?document=|\?layout=|\?mod=|\?conf='
SQLI_PATTERNS='\?id=|\?page=|\?dir=|\?search=|\?category=|\?file=|\?class=|\?url=|\?news=|\?item=|\?menu=|\?lang=|\?name=|\?ref=|\?title=|\?view=|\?topic=|\?thread=|\?type=|\?date=|\?form=|\?join=|\?main=|\?nav=|\?region='
XSS_PATTERNS='\?q=|\?s=|\?search=|\?id=|\?lang=|\?keyword=|\?query=|\?page=|\?keywords=|\?year=|\?view=|\?email=|\?type=|\?name=|\?p=|\?month=|\?image=|\?list_type=|\?url=|\?terms=|\?categoryid=|\?key=|\?login=|\?begindate=|\?enddate='
IMAGE_EXTENSIONS='\.(jpg|jpeg|png|gif|bmp|tiff|svg|webp)$'
WEB_EXTENSIONS='\.(jsp|jspx|asp|aspx|do|mi|action|php|html|htm|cfm|py|rb|pl|cgi)$'
DOC_EXTENSIONS='\.(pdf|doc|docx|xls|xlsx|ppt|pptx|odt|ods|odp|rtf)$'
XML_JSON_EXTENSIONS='\.(xml|json)$'
DEPRECATED_PATTERNS='\?old=|\?legacy=|\?deprecated='
SENSITIVE_INFO_PATTERNS='email=|phone=|password=|secret=|token=|api_key=|auth=|credit_card=|ssn=|dob=|address='
KEYWORD_PATTERNS='preferences|notifications|unsubscribe|validate|invoice|billing|order|tracking|guest|login|register|signup|account|user|profile|security|payment|subscription|confirm|activate|reset|recover|access|feedback|report|support|admin|details|update|settings|config|setup|change|modify|history'

# Command to filter Remote Code Execution (RCE) parameters
grep -E "$RCE_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-rce.txt

# Command to filter Server-Side Request Forgery (SSRF) parameters
grep -E "$SSRF_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-ssrf.txt

# Command to filter Local File Inclusion (LFI) parameters
grep -E "$LFI_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-lfi.txt

# Command to filter SQL Injection (SQLi) parameters
grep -E "$SQLI_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-sqli.txt

# Command to filter Cross-Site Scripting (XSS) parameters
grep -E "$XSS_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-xss.txt

# Command to filter specific file extensions (images)
grep -E "$IMAGE_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/results-images.txt

# Command to filter Open Redirect (OPRI) parameters
grep -E '\?next=|\?url=|\?target=|\?rurl=|\?dest=|\?destination=|\?redir=|\?redirect_uri=|\?redirect_url=|\?redirect=|/redirect/|/cgi-bin/redirect.cgi?|\?out=|\?view=|\?login?to=|\?image_url=|\?go=|\?return=|\?returnTo=|\?return_to=|\?checkout_url=|\?continue=|\?return_path=' $ENDPOINTS_FILE > $RESULT_DIR/results-opri.txt

# Filter email domains
grep -E '@gmail.com|@outlook.com|@hotmail.com|@custom.com|@yahoo.com|@aol.com|@icloud.com|@mail.com|@live.com|@mail.ru|@zoho.com|@gmx.com|@yandex.com|@protonmail.com|@tutanota.com' $ENDPOINTS_FILE > $RESULT_DIR/results-emails.txt

# Filter sensitive information parameters
grep -E "$SENSITIVE_INFO_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-sensitive-info.txt

# Filter specific keywords
grep -E "$KEYWORD_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-keywords.txt

# Command to filter various web file extensions
grep -E "$WEB_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/results-web-extensions.txt

# Command to filter specific file extensions (PDF and similar)
grep -E "$DOC_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/results-docs.txt

# Command to filter XML and JSON file extensions
grep -E "$XML_JSON_EXTENSIONS" $ENDPOINTS_FILE > $RESULT_DIR/results-xml-json.txt

# Command to filter deprecated parameters
grep -E "$DEPRECATED_PATTERNS" $ENDPOINTS_FILE > $RESULT_DIR/results-deprecated.txt

echo "All filtering operations completed by filtex"
