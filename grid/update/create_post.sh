#Input file
_db="post_data/post.txt"
 
# If file exists 
if [[ -f "$_db" ]]
then
	# read file
	while IFS='|' read -r id date category title link author last_marked
	do
	echo $date $category $title $link $author $last_marked

	#make post
    
    done <"$_db"
fi


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
