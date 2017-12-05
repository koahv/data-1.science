psql -U postgres -d ttrssdb3_test -c \
"INSERT INTO public.ttrss_entries (custom_extract) VALUES ('$today'";
