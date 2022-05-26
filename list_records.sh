#!/bin/bash

source ./conf.sh
curl --silent --location --request GET 'https://api.digitalocean.com/v2/domains/'$DOMAIN'/records?per_page=500' \
--header 'Content-Type: application/json' \
--header 'Authorization: Bearer '$TOKEN'' \
| jq -r ".domain_records[] | .name" | grep -v "^@$" | grep -v "^$"


