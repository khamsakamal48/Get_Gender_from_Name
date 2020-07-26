#!/usr/bin/env bash
#
# Copyright (c) 2020 by Kamal Hamza (khamsa.kamal48@gmail.com). All Rights Reserved.
#

#Get Name and API Key
key=$(jq -r '.api_key' API.json)
first_name=$(jq -r '.first' Name.json)
last_name=$(jq -r '.last' Name.json)

#Get Gender
curl -s -H "accept: application/json" -H "X-API-KEY: ${key}" --request GET "https://v2.namsor.com/NamSorAPIv2/api2/json/gender/${first_name}/${last_name}" > Name_Output_1.json && jq . Name_Output_1.json > Name_Output.json && rm -rf Name_Output_1.json;

id=$(jq -r '.id' Name_Output.json)
firstName=$(jq -r '.firstName' Name_Output.json)
lastName=$(jq -r '.lastName' Name_Output.json)
likelyGender=$(jq -r '.likelyGender' Name_Output.json)
genderScale=$(jq -r '.genderScale' Name_Output.json)
score=$(jq -r '.score' Name_Output.json)
probabilityCalibrated=$(jq -r '.probabilityCalibrated' Name_Output.json)
echo "$key,$id,$firstName,$lastName,$likelyGender,$genderScale,$score,$probabilityCalibrated" >> Name_Final.csv;

tail -n 1 Names_List.csv >> Names_Completed.csv;
#Remove the last line from CSV file
sed -i '$d' Names_List.csv;

sleep 1;
