rm out.txt


#rowcount=`psql -tU postgres -d ttrssdb2 -c "SELECT COUNT (*) FROM ttrss_user_entries e WHERE e.marked"`
#ASC LIMIT 1"
#echo $rowcount

 

#END=$rowcount
#for ((i=1;i<=END;i++)); do
#	let "OFFSET0=i-1"
#	psql -tU postgres -o post_data/post$i.txt -d ttrssdb2 -c "SELECT f.updated, g.title, f.title, f.link, d.title, d.site_url, d.feed_url, f.author, e.last_marked FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked ORDER BY f.id ASC LIMIT 1 OFFSET $OFFSET0"
#done


psql -tU postgres -o post_data/post.txt -d ttrssdb2 -c "SELECT f.id, f.updated, g.title, f.title, f.link, f.author, e.last_marked, e.tag_cache, f.content FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked ORDER BY f.id ASC "


# get marked articles in keyword
psql -tU postgres -o post_data/topic_quantum.txt -d ttrssdb2 -c "SELECT f.id, f.updated, g.title, f.title, f.link, f.author, e.last_marked FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked AND f.title LIKE '%quantum%'ORDER BY f.id ASC"

psql -tU postgres -o post_data/topic_linux.txt -d ttrssdb2 -c "SELECT f.id, f.updated, g.title, f.title, f.link, f.author, e.last_marked FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked AND g.title SIMILAR TO '%(Linux|Open%Source)%' ORDER BY f.id ASC"


psql -U postgres -H -o out.txt -d ttrssdb2 -c "SELECT f.updated, g.title, f.title, f.link, d.title, d.site_url, d.feed_url, f.author, e.last_marked FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked"

#psql -U postgres -H -o out.txt -d ttrssdb2 -c "SELECT f.updated, e.last_marked, g.title, f.title, f.link, d.title, d.site_url, d.feed_url FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked"

rm words.txt

psql -U postgres -o words.txt -d ttrssdb2 -c "SELECT f.title FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE e.marked"

#psql -U postgres -H -o out.txt -d o0 -c "SELECT f.updated, g.title, f.title, f.link, d.title, d.site_url, d.feed_url, e.last_marked, f.id FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked"

exit

