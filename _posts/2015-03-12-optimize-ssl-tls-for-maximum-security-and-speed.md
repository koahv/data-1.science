---
layout: post
title: "Optimize SSL/TLS for Maximum Security and Speed"
date: 2015-03-12 19:19:11
categories: Linux
author: Michael Boelen
tags: [performance, system administration, web, ssl, sslv2, sslv3, tls, tls1.0, tls1.1, tls1.2]
---


#### Extract
>Optimize SSL/TLS for Maximum Security and Speed

High Goal Setting
Recently we changed our corporate website into a &#8220;HTTPS only&#8221; version. Most of the content is not secret information, still we have some sensitive areas. The ordering section and downloads, and additional our portal. While some areas were already covered with a lock, we felt it was time to make the jump to cover it all.
Additionally, we believe that we doing everything we can on our website, practicing security hardening ourselves. So that includes buying a SSL certificate, configure our web servers and finally tune it. In this article we share what we learned while doing so.
Nginx Configuration
For the purpose of demonstration, we will show some snippets in this article. While most of it is focused on nginx, the general rules can be applied to others like Apache. In any case, don&#8217;t simply copy snippets, but test them carefully and understand what they are doing.
Let&#8217;s start hardening and tuning!
Disable old protocols
SSL version 2 and 3 are insecure. Several weaknesses in the last years showed that you should no longer use these. Also for companies who need to be PCI DSS compliant, are enforced to remove support for SSLv3.
# Only allow TLS
&nbsp;
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
Select right ciphers
Ciphers are part of the full conversation, deciding how the connection is initiated and maintained, but also how data is encrypted and protected.
Selecting the right ciphers is not easy. All kind of vulnerabilities showed that selecting a wrong cipher can weaken your security defenses. Instead, use the great page of Mozilla, which helps you selecting the right cipher set, tuned to modern browsers.
# Use specific ciphers and let server decide which one to
use.
&nbsp;
ssl_ciphers &#8216;long string of ciphers&#8217;;
ssl_prefer_server_ciphers on;
Exotic HTTPS features
Last years several new concepts have been introduced, to make the web a safer place.
HTTPS configured with HTST, HPKP and forward secrecy.
Forward secrecy
The easy explanation for this feature, is ensuring that in the event of a private key is exposed, previous recorded messages can not be decrypted. The more technical background is that no additional keys can be gathered, when another key is compromised.
Next Protocol Negotiation
NPN is an extension to the TLS protocol, to set the transport protocol. In this case we have activated SPDY version 3.1. Configuration of this item will follow in sections below.
OCSP stapling
Instead of just relying on clients checking for a revocation list, we can help saving a lot of bandwidth with OCSP stapling. The server will do the checking instead and stamp it with a recent check. This way the client knows the certificate is still valid.
HTST
HTST, or HTTP Strict Transport Security, helps the browser to save a preferred protocol (HTTPS). This means that after a redirect from HTTP to HTTPS, the browser next time remembers to go directly to HTTPS. This helps with ensuring the right protocol is used, while limiting unneeded redirects at the same time.

# Redirect other domains, including www.domain.com
server {
  listen 80;
  index index.html index.htm;
  server_name *.domain.com *.other-domain.com;
  add_header "Cache-Control" "public, max-age=31536000";
  return 301 https://domain.com;
}

See also the previous article about HTST.
Public Key Pinning
HTTP Public Key Pinning, or HPKP is a way to glue a hostname and a public key (of the certificate). This is done at the level of the browser, which have static lists.
Performance
On the web every second counts. So where possible, allow clients to cache data and do compression.
Compression
First level of performance tuning is sending less data on the line, with the help of file compression. For this the common used gzip module is used, which all modern browsers understand as well.
So we enable gzip, define what gets compressed, how much and how much buffering we use.
# Turn on gzip and disable it for MSIE6
gzip on;
gzip_disable &#8220;msie6&#8221;;
&nbsp;
# Also zip proxied requests
gzip_proxied any;
# Compression level, only do zipping if minimum length is 1100 bytes
gzip_comp_level 6;
gzip_min_length 1100;
gzip_buffers 16 8k;
# Define gzip for specific types (we don&#8217;t zip fonts)
gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
# Enabled (insert Vary: Accept-Encoding header)
gzip_vary on;
Caching
While compression is great, it is even better if we limit the amount of requests to our server. We want after all security AND performance.
While browsers are already smart in knowing which files have been changed, it still sends out requests.
Firefox network analyzer showing caching of objects
The orange triangles show that requests have been done and returned with a 304 (not modified). The green circle is a successful 200 response (Ok) of the main test page.
So we want to reduce the amount of requests to a bare minimum. So we picked an expire date of 1 week. Long enough for normal users which return on a regular basis, while not caching entries too long. After all, when releasing new content, we want to push that to the client.

location ~* \.(?:css|js) {
   root /data/website/;
   expires 1w;
   add_header Cache-Control public;
   add_header Vary Accept-Encoding;
   access_log off;
 }

This configuration sets both an encoding (for compression) and sets caching to 1 week. That means that only once a week a new copy of the file is retrieved, unless the user forces a new download (CTRL+F5). Since we don&#8217;t care about logging the request of CSS and Javascript files, we don&#8217;t log it. Another slight performance win in that area as well.
HTTPS tuning
When it comes to HTTPS, a slow connection is usually caused due to the slow handshake. The main reason is network latency, in combination with the amount of packets needed to finish the handshake. The more packets, the longer it takes.
Enable SPDY
Enabling SPDY is easy, just add it to the listen statement. Note, you need a recent version of nginx.
listen 443 spdy;
listen [::]:443 default ipv6only=on spdy;
Advertise also the availability of SPDY, by adding a header to the location block.
add_header Alternative-Protocol 443:npn-spdy/3.1;
Turn off SPDY compression
To counter the CRIME exploit, turn off compression.
# Turn off SPDY compression
spdy_headers_comp 0;
Conclusion
After all this tuning, we can learn a few things:
SSL versus TLS
SSL is old and insecure. Therefore version 2 and 3 should be disabled. TLS is fine, with TLSv1.1 and TLSv1.2 being preferred. TLSv1 might be still needed, for older browsers or some tooling (e.g. some versions of wget).
Use SPDY
Until the HTTP/2 protocol is there, make use of SPDY to enhance the speed of HTTPS.
Security AND Performance
Instead of security battling against performance, the combination is possible. Test your SSL configuration with SSL Labs. Use the GZIP module for nginx for maximum compression. Finally, use website speed testing tools like Pingdom to determine any bottlenecks.
Other resources
Submit certificate key pinning: https://hstspreload.appspot.com/
Chrome
Internal link for Chrome to check HTST database: chrome://net-internals/#htst
&nbsp;
The post Optimize SSL/TLS for Maximum Security and Speed appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/optimize-ssl-tls-for-maximum-security-and-speed/)

id:  191473
