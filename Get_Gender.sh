#!/usr/bin/env bash
#
# Copyright (c) 2020 by Kamal Hamza (khamsa.kamal48@gmail.com). All Rights Reserved.
#

#Get Name and API Key
key=$(jq -r '.api_key' API.json)
first_name=$(jq -r '.first' Name.json)
last_name=$(jq -r '.last' Name.json)

#Get Gender
curl -X GET "https://v2.namsor.com/NamSorAPIv2/api2/json/gender/${first_name}/${last_name}" -H "accept: application/json" -H "X-API-KEY: ${key}" 2>&1 | tee Name_Output.json;

id=$(jq -r '.id' Name_Output.json)
firstName=$(jq -r '.firstName' Name_Output.json)
lastName=$(jq -r '.lastName' Name_Output.json)
likelyGender=$(jq -r '.likelyGender' Name_Output.json)
genderScale=$(jq -r '.genderScale' Name_Output.json)
score=$(jq -r '.score' Name_Output.json)
probabilityCalibrated=$(jq -r '.probabilityCalibrated' Name_Output.json)
echo "$key,$number_orig,$valid,$number,$local_format,$international_format,$country_prefix,$country_code,$country_name,$location,$carrier,$line_type" >> Name_Final.csv;

tail -n 1 Names_List.csv >> Names_Completed.csv;
#Remove the last line from CSV file
sed -i '$d' Names_List.csv;
