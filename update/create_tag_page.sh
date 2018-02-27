#!/usr/bin/env bash

# get marked ids'
rm post_data/id.txt
psql -t -U postgres -o post_data/id.txt -d ttrssdb2 -c "SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE e.marked ORDER BY f.id DESC"

sed -i '$ d' post_data/id.txt

cp tags.md.bak tags.md
rm taglist.txt

# for each id
while IFS=$'\n' read -r line_data; do # < post_data/id.txt

echo $line_data

	category=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT g.title FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")
	# echo $category

	title=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.title FROM ttrss_entries f WHERE f.id = $line_data")
	# echo $title

	link=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.link FROM ttrss_entries f WHERE f.id = $line_data")
	# echo $link

	tags=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT e.tags_new FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE f.id = $line_data")

	echo $tags >> taglist.txt
	
	#mod_tags="$(echo -e ${tags})"


# replace new lines with comma
mod_tags=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/,/g' taglist.txt)

echo $mod_tags > taglist.txt

# remove duplicates
awk 'BEGIN{RS=ORS=","} !seen[$0]++' taglist.txt > taglist2.txt

# for each tag
while IFS=$',' read -r tag; do # < taglist2.txt

#	echo "$tag " > tags.md


	done < taglist2.txt


done < post_data/id.txt


#mod_tags2=`cat taglist.txt`



#id=$(psql -X -A -U postgres -d ttrssdb2 --single-transaction --set ON_ERROR_STOP=on --no-align -t --quiet -c "SELECT f.id FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.tags_new LIKE '%$tag%'")
	
#	echo $id >> id_tag.txt
	

