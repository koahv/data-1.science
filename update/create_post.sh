#Input file
_db="post_data/post.txt"


# If file exists 
if [[ -f "$_db" ]]
then
	# read file
	while IFS='|' read -r id date category title link author last_marked tags snippet
	do
	
	# make each post

	# echo $date $category $title $link $author $last_marked $tags

	# split date and time into two vars
	split_date=($date)

	# echo post date ${split_date[0]}
	# echo post time ${split_date[1]}

	# modify title for post filename
	
	# create url friendly post name
	mod_title1="$(echo -e "${title}" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"
	# echo $mod_title1
	
	# remove leading and trailing whitespaces
	mod_title2="$(echo -e "${title}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' | tr -d '"')"
	
	# create character friendly title
	mod_title3="$(echo -e "${mod_title2}" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/\ /g | sed -r s/^-+\|-+$//g)"

	# remove leading and trailing whitespaces from url

	mod_link1="$(echo -e "${link}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"

	mod_snippet1="$(echo -e "${snippet}" | sed -e 's/<[^>]*>//g')"


	if [[ -z "${author// }" ]]
	then
		author="unknown author"
	fi


	# clear files
	rm post_data/${split_date[0]}-$mod_title1.md
	
	# write post
	echo -e "---\nlayout: post\ntitle: \"$mod_title2\"\ndate: $date\ncategories: $category\nauthor: $author\ntags: $tags\n---\n\n\n>$mod_snippet1\n\n[Visit Link]($mod_link1)\n\nid: $id" >> post_data/${split_date[0]}-$mod_title1.md
	
	# include article extracts/notes

	done <"$_db"
fi






#sed -i 's/ \+/ /g' $_db
#cat $_db | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]'



#remove | char
#sed -i 's/|//g' post_data/post.txt


#IFS='|' read -r -a array < post_data/post.txt

#for index in "${!array[@]}"
#do
#    echo "$index ${array[index]}"
#done


#cat post_data/post.txt | while IFS=: read first last varx
#do
#    echo "first='$first' last='$last' varx='$varx'"
#    # do something
#done



	# modify title for post filename

	# mod_title1="$(echo -e "${title}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	# echo -e "mod_title1='${mod_title1}'"	


	# mod_title2=${mod_title1// /-}
	# echo $mod_title2

	# echo $mod_title2 #| tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]'

	# echo ${mod_title2//[\':._]/}

