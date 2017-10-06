rm out.txt

psql -U postgres -H -o out.txt -d ttrssdb2 -c "SELECT f.updated, g.title, f.title, f.link, d.title, d.site_url, d.feed_url, e.last_marked FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked"

#psql -U postgres -H -o out.txt -d ttrssdb2 -c "SELECT f.updated, e.last_marked, g.title, f.title, f.link, d.title, d.site_url, d.feed_url FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked"

rm words.txt

psql -U postgres -o words.txt -d ttrssdb2 -c "SELECT f.title FROM ttrss_user_entries e INNER JOIN ttrss_entries f ON f.id = e.ref_id WHERE e.marked"

#psql -U postgres -H -o out.txt -d o0 -c "SELECT f.updated, g.title, f.title, f.link, d.title, d.site_url, d.feed_url, e.last_marked, f.id FROM ttrss_user_entries e INNER JOIN ttrss_feeds d ON d.id = e.feed_id INNER JOIN ttrss_entries f ON f.id = e.ref_id INNER JOIN ttrss_feed_categories g ON d.cat_id = g.id WHERE e.marked"

exit

