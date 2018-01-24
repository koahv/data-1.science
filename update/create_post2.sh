#!/usr/bin/env bash
rm post_data/id.txt
psql -t -U postgres -o post_data/id.txt -d ttrssdb2 -c "SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE e.marked ORDER BY f.id DESC"

sed -i '$ d' post_data/id.txt

while IFS=$'\n' read -r line_data; do

# put db data into vars

date=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.updated FROM ttrss_entries f WHERE f.id = $line_data")
#echo $date

category=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT g.title FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
#echo $category

title=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.title FROM ttrss_entries f WHERE f.id = $line_data")
#echo $title

link=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.link FROM ttrss_entries f WHERE f.id = $line_data")
#echo $link

author=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.author FROM ttrss_entries f WHERE f.id = $line_data")
#echo $author

last_marked=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.last_marked FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
#echo $last_marked

tags=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.tag_cache FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
#echo $tags

extract=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.content FROM ttrss_entries f WHERE f.id = $line_data")
#echo $extract

#custom_extract=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.custom_extract FROM ttrss_entries f WHERE f.id = $line_data")
#echo $custom_extract

custom_extract=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.note FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")


# strip html tags
mod_extract="$(echo -e "${extract}" | sed -e 's/<[^>]*>//g')"
# truncate
mod_extract2="$(echo -e ${mod_extract:0:1000})"


# create url friendly post name
mod_title1="$(echo -e "${title}" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"


# replace null entries

if [[ -z "${author// }" ]]
then
	author="unknown author"
fi

if [[ -z "${custom_extract// }" ]]
then
	custom_extract="factsheet unavailable"
fi


# separate date/time into array 

split_date=($date)


mod_tags="$(echo -e "${tags}" | sed -e 's/,/, /g')"
#echo $mod_tags








# store json api response to var
response=$(curl -X POST \
    -H "x-textrazor-key: $api_key_value" \
    -d "extractors=topics" \
    -d "url=$link" \
    https://api.textrazor.com/ | jq -r '.response.topics')

rm response.txt

echo -e "$response" >> response.txt

rm extracted_tags.txt


for output in $(echo "${response}" | jq -r '.[] | @base64'); do  

	request() {
	
		echo ${output} | base64 --decode | jq -r ${1}

	}

	label=$(request '.label')
	score=$(request '.score')

	if [[ "$score" > 0.7 ]]; then
	
		echo -e "$label" >> extracted_tags.txt

	fi

done  








	

# clear files
rm post_data/${split_date[0]}-$mod_title1.md
	
	# write post
echo -e "---\\nlayout: post\\ntitle: \"$title\"\\ndate: $date\\ncategories: $category\\nauthor: $author\\ntags: [$mod_tags]\\n---\\n\\n\\n#### Extract\\n>$mod_extract2...\\n\\n#### Factsheet\\n>$custom_extract\\n\\n[Visit Link]($link)\\n\\nid: $line_data" >> post_data/${split_date[0]}-$mod_title1.md





done < post_data/id.txt








#read id date category title link author last_marked tags snippet factsheet <<< $(psql \
	#	-X \
	#	-U postgres \
	#	-d ttrssdb2 \
	#	--single-transaction \
	#	--set ON_ERROR_STOP=on \
	#	--no-align \
	#	-t \
	#	--field-separator ' ' \
	#	--quiet \
	#	-c "SELECT f.id, f.updated, g.title, f.title, f.link, f.author, e.last_marked, e.tag_cache, f.content, f.custom_extract FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")





#split between |||


#IFS='|||' read -a split_row <<< "$row"

#echo "id: ${split_row[0]}"
#echo "date: ${split_row[1]}"
#echo "category: ${split_row[2]}"
#echo "title: ${split_row[3]}"
#echo "link: ${split_row[4]}"
#echo "author: ${split_row[5]}"
#echo "last_marked: ${split_row[6]}"
#echo "tags: ${split_row[7]}"
#echo "extract ${split_row[8]}"
#echo "factsheet: ${split_row[9]}"






#IFS='}{' read -r id date category title link author last_marked tags snippet factsheet <<< $mod_row
#echo $id
#echo $date
#echo $category
#echo $title
#echo $link
#echo $author
#echo $last_marked
#echo $snippet
#echo $factsheet

#str="Learn to Split a String in Bash Scripting"
 
#IFS='}{' read -ra ADDR <<< "$mod_row"
#for i in "${ADDR[@]}"; do
#    echo "$i"
#    echo
#done




#mod_row="$(echo -e "${row}" | sed -e 's/<[^>]*>//g')"
#echo $mod_row

