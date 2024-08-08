#!/bin/bash

awk -F '[?=]' '
{
    path = $1;
    param = $2 "=" $3;
    
    # Construct a unique key based on the path and parameter
    key = path "?" param;
    
    # Track the best URL for each key
    if (!seen[key]++) {
        best_url[key] = $0;
    } else {
        # Compare and keep the most specific URL
        if ($0 > best_url[key]) {
            best_url[key] = $0;
        }
    }
}
END {
    for (i in best_url) {
        print best_url[i];
    }
}' cleaned_urls.txt > clean.txt
