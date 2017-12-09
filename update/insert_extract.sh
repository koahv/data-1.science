#!/usr/bin/env bash
#Input file
_db="extract.txt"

if [[ -f "$_db" ]] # file exists
then
	# read file
	while IFS='|' read -r id title factsheet
	do
	# echo $id
	# echo $title
	# echo $factsheet
	psql -U postgres -d ttrssdb2 -c "UPDATE ttrss_entries SET custom_extract = '$factsheet' WHERE ID = $id RETURNING id, custom_extract;";
	
	done <"$_db"
fi

# Alternatively run this sql in pgadmin and enter manually
# SELECT f.id, f.updated, g.title, f.title, f.link, f.author, e.last_marked, e.tag_cache, f.content, f.custom_extract FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked ORDER BY f.updated DESC
