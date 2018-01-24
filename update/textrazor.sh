#!/usr/bin/env bash

# keep key content outside of git directory
api_key_value=`cat ~/.textrazorapi.key`

while IFS=$'\n' read -r line_data; do

	link=$(psql -X -A -t \
			-U postgres \
			-d ttrssdb2 \
			--single-transaction \
			--set ON_ERROR_STOP=on \
			--no-align \
			--quiet \
			-c "SELECT f.link FROM ttrss_entries f WHERE f.id = $line_data")
	echo $link

	# put this in a for loop for each id in id.txt - get url for each id
	# enter how many requests the user would like to complete
	# store which requests have been completed and do not complete these requests again

	# store json api response to var
	response=$(curl -X POST \
		-H "x-textrazor-key: $api_key_value" \
		-d "extractors=topics" \
		-d "url=$link" \
		https://api.textrazor.com/ | jq -r '.response.topics')

	# rm response.txt
	# echo -e "$response" >> response.txt

	rm extracted_tags.txt

	for output in $(echo "${response}" | jq -r '.[] | @base64'); do  

		request() {
	
			echo ${output} | base64 --decode | jq -r ${1}
		}

		label=$(request '.label')
		score=$(request '.score')
	
		if [[ "$score" > 0.8 ]]; then
		
			echo -e "$label" >> extracted_tags.txt
	
		fi
		

	done 

	sed -i ':a;N;$!ba;s/\n/, /g' extracted_tags.txt
	
done < post_data/id.txt

