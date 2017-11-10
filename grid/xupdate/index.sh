#rm out.txt
wget http://localhost/out.txt
mv out.txt index.html

wget -O feed.xml "http://localhost/tt-rss/public.php?op=rss&id=-1&key=vyn7su59c7b50850ac3"
sed -i '1d' feed.xml


sed -i '1s/^/<HTML>\n<HEAD>\n<TITLE>data-1.science<\/TITLE>\n<meta charset="UTF-8"><meta name="google-site-verification" content="cjBnLqqABjC1aHNwKlgEq_tqFvgpE__jxiJaU_aHTS4" \/><meta name="description" content="Top Science Breakthrough News" \/><link rel="stylesheet" type="text\/css" href="jquery.dataTables.0.css"><script src="jquery-1.10.2.min.js"><\/script><script src="jquery.dataTables.min.js"><\/script><script src="initialise.js"><\/script>\n<\/HEAD>\n<BODY onload="myFunction()" style="margin:0;"><div id="loader"><\/div><div style="display:none;" id="myDiv" class="animate-bottom"><\/div>/' index.html

#\n<script async src="\/\/pagead2.googlesyndication.com\/pagead\/js\/adsbygoogle.js"><\/script>\n<script>\n  (adsbygoogle = window.adsbygoogle || []).push({\n  google_ad_client: "ca-pub-1180084567973917",\n  enable_page_level_ads: true\n  });\n<\/script>\n

sed -i 's/<table border="1">/<table border="0" id="example" class="display"><thead>/g' index.html

echo \<a href=\/word\/cloud.xhtml\>\<font size=\"2\"\>Word Cloud\<\/font\>\<\/a\> \| \<a href=\/feed.xml\>\<font size=\"2\"\>RSS\/Atom\<\/font\>\<\/a\>  >> index.html

#echo \<a href=/word/coud.xhtml\>\<font size=\"2\"\>info\<\/font\>\<\/a\> \|  >> index.html

#echo \<a href=info.txt\>\<font size=\"2\"\>info\<\/font\>\<\/a\> \| \<a href=\/word\/cloud.xhtml\>\<font size=\"2\"\>cloud\<\/font\>\<\/a\>  >> index.html

#echo \<?php include_once\(\"analyticstracking.php\"\) ?\> \<\/BODY\>\<\/HTML\> >> index.html

sed -i '17s/^/<\/tr><\/thead><tbody> /' index.html

sed -i 's/<\/table>/<\/tbody><\/table>/g' index.html 

sed -i 's/td align/td nowrap align/g' index.html

sed -i 's_^\([^>]\+right">\)\([[:digit:]]\+\)_\1<a href="archive/\2-l.svgz">svgz</a>_' index.html

mv index.html ../index.html
mv feed.xml ../feed.xml
exit
