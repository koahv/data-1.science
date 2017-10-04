#!/bin/bash
echo shell:locate.sh
time sh locate.sh
echo shell:index.sh
time sh index.sh
cd ..
git add .
git commit -m "update"
git push
echo exit;exit
