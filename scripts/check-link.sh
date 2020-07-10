#!/bin/bash

count=0
links=$(rg '\[.+\]\((.+?\.scm)\)' -r '$1' -o README.md)
for link in $links; do
  if [[ ! -e "$link" ]]; then
    count=$((count + 1))
    echo "$link is broken"
  fi
done

if [[ $count > 0 ]]; then
  exit 1
fi
