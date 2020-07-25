#!/usr/bin/env bash
#
# Copyright (c) 2020 by Kamal Hamza (khamsa.kamal48@gmail.com). All Rights Reserved.
#

clear;

#Housekeeping
rm -rf Name.json;
rm -rf Names_New.csv;

#Remove already processed lines from CSV
join -v 1 -t, <(sort -t, Names_List.csv) <(sort Names_Completed.csv) > Names_Final.csv;
mv Names_Final.csv Names_List.csv;

#Create blank.csv file
touch Names_New.csv;

#Export the header to CSV file
cat head.txt Names_New.csv > Names_New_1.csv;
mv Names_New_1.csv Names_New.csv;

#Export (Append) the last line to CSV file
tail -n 1 Names_List.csv >> Names_New.csv;

#Remove blank row
sed -i '/^$/d' Names_New.csv;

#Remove blank row
awk -F, 'length>NF+1' Names_New.csv > Names_New_1.csv;
mv Names_New_1.csv Names_New.csv;

#Check if Names_New.csv has some data to upload
a=$(cat Names_New.csv | wc -l)

if [[ "$a" -eq 1 ]]; then
  echo "No phone numbers to verify";
else
  #Convert CSV to JSON
  csvjson Names_New.csv > Name.json;

  #Remove brackets from JSON file
  tr -d '[' < Name.json > Name_1.json && sleep 1;
  tr -d ']' < Name_1.json > Name_2.json && sleep 1 && rm -rf Name_1.json;

  #Beautify JSON file
  jq . Name_2.json > Name.json;
  rm -rf Name_2.json;

  #Get Gender
  ./Get_Gender.sh;
fi
