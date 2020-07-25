#!/usr/bin/env bash
#
#
# Copyright (c) 2020 by Kamal Hamza (khamsa.kamal48@gmail.com). All Rights Reserved.
#
#

#Take a backup of Names checked
echo "This script will verify the phone numbers using NamSor API."
echo ""
echo "Make sure that you have already taken backup of the Names already checked."
echo ""
echo "Enter the Names in 'Names_List.csv'."
echo ""
read -r -p "Enter your NamSor API Key:" key
#Length of Key
length=${#key}

case $length in
  0 )
  echo "No API Key entered."
  echo "Will exit now."
    ;;
    * )
    rm -rf *.json;

    #Prepare JSON file
    jq -n --arg key "$key" '{ "api_key": $key }' > API_1.json;

    #Beautify JSON file
    jq . API_1.json > API.json;
    rm -rf API_1.json;

    rm -rf Names_Completed.csv;
    rm -rf Names_New.csv;

    touch Names_Completed.csv;

    #Count the names to process
    name_count=$(cat Names_List.csv | wc -l)

    if [[ "$name_count" -le 5000 ]]; then
      echo "You can process all the names";
      for i in $(seq $name_count); do ./csvtojson.sh; done
    else
      echo "Provide only 5,000 names at a time"
      echo "Visit https://v2.namsor.com/ and create a new account to get additional API Keys."
    fi
      ;;
esac
