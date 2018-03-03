#!/usr/bin/env bash

# get marked ids'
rm post_data/id.txt
psql -t -U postgres -o post_data/id.txt -d ttrssdb2 -c "SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE e.marked ORDER BY f.id DESC LIMIT 2"

sed -i '$ d' post_data/id.txt

cp tags.md.bak tags.md
rm taglist.txt

# for each id
while IFS=$'\n' read -r line_data; do # < post_data/id.txt

	echo $line_data

	tags=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.tags_new FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")

	echo $tags | tr , \\n  >> taglist.txt

done < post_data/id.txt

	
# remove duplicates
awk 'BEGIN{RS=ORS="\n"} !seen[$0]++' taglist.txt > taglist2.txt

# alphabetise
sort taglist2.txt > taglist_sorted.txt

# remove empty lines
awk 'NF' taglist_sorted.txt > taglist_sorted2.txt

# cleanup
rm taglist.txt taglist2.txt taglist_sorted.txt



echo "<ul class=\"tags\">" >> tags.md


# for each tag
while IFS=$'\n' read -r tag_data; do # < post_data/taglist_sorted2.txt

	# psql get info where tag like xyz

	#id=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE '$tag_data' = any (regexp_split_to_array(e.tags_new, ','::text))")

	# SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE ',' || e.tags_new || ',' LIKE '%$tag_data%'

	count=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT COUNT(*) FROM ttrss_user_entries e WHERE e.tags_new LIKE '%$tag_data%'")

	


	echo $tag_data
	
	# echo $id
	

	mod_tag_data="$(echo -e "${tag_data}" | sed -e 's/ /+/g')"
	
	echo "<li><a href=\"#$mod_tag_data\" class=\"tag\"> $tag_data <span>($count)</span></a></li>" >> tags.md





done < taglist_sorted2.txt

echo "</ul>" >> tags.md

while IFS=$'\n' read -r tag_data; do # < post_data/taglist_sorted2.txt

	mod_tag_data="$(echo -e "${tag_data}" | sed -e 's/ /+/g')"

	id=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE '$tag_data' = any (regexp_split_to_array(e.tags_new, ','::text))")


	echo "<div><h2 id =\"$mod_tag_data\">$tag_data</h2>" >> tags.md



	# for each post that matches current tag
	for i in $id; do
		
		echo $i


		title=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.title FROM ttrss_entries f WHERE f.id = $i")
		echo $title

		link=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.link FROM ttrss_entries f WHERE f.id = $i")
		echo $link
		
		echo "<div><span style=\"float: left;\"><a href=\"$link\">$title</a></span></div>" >> tags.md
		
        done

	echo "</div>" >> tags.md


done < taglist_sorted2.txt




#

		#category=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT g.title FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $i")
		#echo $category

