#!/usr/bin/env bash

echo shell:textrazor.sh
time sh textrazor.sh

echo shell:create_post2.sh
time sh create_post2.sh

echo shell:locate.sh
time sh locate.sh

echo shell:index.sh
time sh index.sh

#echo mv:words.txt
#mv words.txt ../gird/word/

echo shell:words.sh
sh word_cloud/words.sh

cd ..
#git pull
git add .
git commit -m "update"
git push

echo exit;exit
