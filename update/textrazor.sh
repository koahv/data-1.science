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
	#echo $link

	tags=$(psql -X -A -t \
			-U postgres \
			-d ttrssdb2 \
			--single-transaction \
			--set ON_ERROR_STOP=on \
			--no-align \
			--quiet \
			-c "SELECT e.tag_cache FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
	# echo $tags

	has_imported_tags=$(psql -X -A -t \
			-U postgres \
			-d ttrssdb2 \
			--single-transaction \
			--set ON_ERROR_STOP=on \
			--no-align \
			--quiet \
			-c "SELECT e.has_imported_tags FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")

	# store which requests have been completed and do not complete these requests again
	
	# echo $has_imported_tags


	if [[ -z "${has_imported_tags// }" ]]; then

	#if [ -z "$has_imported_tags" -eq "true" ]; then

		# store json api response to var
		response=$(curl -X POST \
			-H "x-textrazor-key: $api_key_value" \
			-d "extractors=topics" \
			-d "url=$link" \
			https://api.textrazor.com/ | jq -r '.response.topics')

		rm extracted_tags.txt
	
		for output in $(echo "${response}" | jq -r '.[] | @base64'); do  
	
			request() {

				echo ${output} | base64 --decode | jq -r ${1}
			}

			label=$(request '.label')
			score=$(request '.score')
	
			if [[ "$score" > 0.9 ]]; then
		
				echo -e "$label" >> extracted_tags.txt
	
			fi
		

		done 
	
		# replace new lines with commas
		sed -i ':a;N;$!ba;s/\n/,/g' extracted_tags.txt

		extracted_tags=`cat extracted_tags.txt`

		# check if existing tags are null
		if [[ -z "${tags// }" ]]; then
			comma=""
		else
			comma=","
		fi

		append_tags="$(echo -e "${tags}${comma}${extracted_tags}")"
	
		#echo $append_tags

		
		psql -U postgres -d ttrssdb2 -c "UPDATE ttrss_user_entries SET tag_cache = '$append_tags' WHERE ref_id = $line_data RETURNING ref_id, tag_cache;";


		psql -U postgres -d ttrssdb2 -c "UPDATE ttrss_user_entries SET has_imported_tags = true WHERE ref_id = $line_data RETURNING ref_id, has_imported_tags;";

		
	fi





	
done < post_data/id.txt

