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
