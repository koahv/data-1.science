#Input file
_db="post_data/post.txt"


# If file exists 
if [[ -f "$_db" ]]
then
	# read file
	while IFS='|' read -r id date category title link author last_marked
	do
	
	# make each post

	# echo $date $category $title $link $author $last_marked

	# split date and time into two vars
	split_date=($date)

	# echo post date ${split_date[0]}
	# echo post time ${split_date[1]}

	# modify title for post filename

	mod_title1="$(echo -e "${title}" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z)"
	# echo $mod_title1
	
	rm post_data/${split_date[0]}-$mod_title1.md
	echo -e "---\nlayout: post\ntitle: $title\ndate: $date\ncategories: $category\n---\n\ncontent" >> post_data/${split_date[0]}-$mod_title1.md

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

