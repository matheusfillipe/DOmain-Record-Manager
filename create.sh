#!/bin/bash

source ./conf.sh

existing=($(./list_records.sh))

for i in "${SUBS[@]}"
do
  for j in "${existing[@]}"
  do
    if [ "$i" == "$j" ]; then
      echo "Record for ${i}.${DOMAIN} already exists"
      echo "Skipping $i"
      continue 2
    fi
  done
  echo "Creating record for ${i}.${DOMAIN}"
  curl --location --request POST 'https://api.digitalocean.com/v2/domains/'$DOMAIN'/records' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer '$TOKEN'' \
  --data-raw '{
      "type": "A",
      "name": "'$i'",
      "data": "'$IP'",
      "priority": null,
      "port": null,
      "ttl":  3600,
      "weight": null,
      "flags": null,
      "tag": null
  }'
done
