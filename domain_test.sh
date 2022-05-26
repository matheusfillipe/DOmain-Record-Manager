#!/bin/bash

source ./conf.sh

for i in "${SUBS[@]}"
do
  ping $i.$DOMAIN -c 1 -W 1
  if [ $? -eq 0 ]; then
    echo "$i.$DOMAIN is up"
  else
    echo "$i.$DOMAIN is down"
  fi
done
