#!/usr/bin/env bash
rm post_data/id.txt
psql -t -U postgres -o post_data/id.txt -d ttrssdb2 -c "SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE e.marked ORDER BY f.id DESC"
sed -i '$ d' post_data/id.txt


while IFS=$'\n' read -r line_data; do # < post_data/id.txt
 

	# put db data into vars
	date=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.updated FROM ttrss_entries f WHERE f.id = $line_data")
#	 echo $date

	category=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT g.title FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
	# echo $category

	title=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.title FROM ttrss_entries f WHERE f.id = $line_data" | sed -e 's/"//g')
	# echo $title

	link=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.link FROM ttrss_entries f WHERE f.id = $line_data")
	# echo $link

	author=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.author FROM ttrss_entries f WHERE f.id = $line_data")
	# echo $author

	last_marked=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.last_marked FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
#	 echo $last_marked

	tags=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.tags_new FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
	# echo $tags

	tags_old=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.tag_cache FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE f.id = $line_data")
	# echo $tags

	extract=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.content FROM ttrss_entries f WHERE f.id = $line_data")
	# echo $extract

	# custom_extract=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.custom_extract FROM ttrss_entries f WHERE f.id = $line_data")
	# echo $custom_extract

	custom_extract=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.note FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")


# if tags_old contains d1featured then append to mod_tags





	# strip html tags
	mod_extract="$(echo -e "${extract}" | sed -e 's/<[^>]*>//g')"

	# truncate
	mod_extract2="$(echo -e "#### Extract\\n>${mod_extract:0:750}...")"

	# create url friendly post name
	mod_title1="$(echo -e "${title}" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"

	# separate date/time into array 
	split_date_0=($last_marked)
	split_date_1=($date)


	if [[ $tags_old = *"d1featured"* ]]; then

		echo "FEATURED POST: $title"

		if [[ -z "${tags// }" ]]; then
		
			mod_tags="tags: [Featured]"
					
		else

			mod_tags="$(echo -e "tags: [${tags},Featured]" | sed -e 's/,/, /g')"
	
		fi

	else

		mod_tags="$(echo -e "tags: [${tags}]"  | sed -e 's/,/, /g')"

	fi



			



	# echo $mod_tags
	
	#header="$(echo -e "${custom_extract}" | sed -e 's/##\(.*\)##/\1/')"
	
	

	# split the custom extract between an agreed delimeter 	
	IFS="#" read digest factsheet <<< $custom_extract
	
	#echo $digest;echo done;echo $factsheet
	







	# replace null entries
	if [[ -z "${author// }" ]]; then
		author="unknown author"
	fi

	if [[ -z "${factsheet// }" ]]; then
		mod_factsheet=""
	else
		mod_factsheet="#### Factsheet\\n>$factsheet"
	fi

	if [[ -z "${digest// }" ]]; then
		mod_digest=""
	else
		mod_digest="#### Digest\\n>$digest"
		mod_extract2=""
	fi





	# clear files
	# rm post_data/${split_date_1[0]}-$mod_title1.md

	# write post
	echo -e "---\\nlayout: post\\ntitle: \"$title\"\\ndate: ${split_date_0[0]}\\ncategories: $category\\nauthor: $author\\n$mod_tags\\n---\\n\\n\\n$mod_digest\\n\\n$mod_extract2\\n\\n$mod_factsheet\\n\\n[Visit Link]($link)\\n\\n" > post_data/${split_date_1[0]}-$mod_title1.md

#tags: [$mod_tags]\\n

done < post_data/id.txt



#	echo -e "---\\nlayout: post\\ntitle: \"$title\"\\ndate: ${split_date_0[0]}\\ncategories: $category\\nauthor: $author\\n$mod_tags\\n---\\n\\n\\n#### Digest\\n>$digest\\n\\n#### Extract\\n>$mod_extract2...\\n\\n#### Factsheet\\n>$factsheet\\n\\n<b>Tags</b>\\n$taglist\\n\\n[Visit Link]($link)\\n\\n" >> post_data/${split_date_1[0]}-$mod_title1.md






	#echo "<ul>" >> taglist.txt

	#for i in $(echo $tags | sed "s/,/ /g"); do
    	#	echo "<li>$i</li>" >> taglist.txt
	#done
	
	#echo "</ul>" >> taglist.txt

	#taglist=`cat taglist.txt`







#	rm tag_links.txt
#	export IFS=","
#	for word1 in $tags; do
#		
#		for word2 in $tags; do
#
#			if [ "$word1" != "$word2" ]; then
#
# 				# echo "$word"
#				# psql select links where tag_cache like $tag
#		
#				links=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.title, f.link FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked AND e.tag_cache LIKE '%$word1%' AND e.tag_cache LIKE '%$word2%'")
#				
#				echo
#				echo $word1
#				echo $word2
#				
#				echo -e $links >> tag_links.txt 
#				echo
#
#			
#				mod_links="$(echo -e "${links}" | sed -e 's/|/](/g'  | sed -e 's/$/)<\/li>/g' | sed 's/^/<li>[/')"
#				#echo \[$mod_links\)
#		
#				# echo -e "$word" >> post_data/${split_date[0]}-$mod_title1.md
#
#			fi
#			
#		done
#
#	tag_links="$(sort tag_links.txt | uniq -u)"
#	echo -e "$tag_links" >> post_data/${split_date[0]}-$mod_title1.md
	

#	done

