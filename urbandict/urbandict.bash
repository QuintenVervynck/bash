#!/bin/bash
curl -s "https://api.urbandictionary.com/v0/tooltip?term=$1" | python3 -c "import sys, json, html; print(html.unescape(json.load(sys.stdin)['string']).split('\n',2)[1])"
