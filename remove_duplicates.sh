#!/bin/bash

source ./conf.sh
dup=($(./list_records.sh | sort | uniq -d))

for i in "${dup[@]}"
do
  echo "Duplicate: $i"
  id=$(curl --silent --location --request GET 'https://api.digitalocean.com/v2/domains/'$DOMAIN'/records?per_page=500' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer '$TOKEN'' \
  | jq -r '.domain_records[] | select(.name=="'$i'")' | jq -r '.id' | tail -1)

  echo "DELETING id: $id"
  curl -X DELETE \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer '$TOKEN'' \
  "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$id"
done
