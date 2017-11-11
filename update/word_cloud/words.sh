# called from ../run.sh
#rm words.txt
#wget http://localhost/words.txt
sed -i '1d;2d' word_cloud/words.txt


function wordfrequency() {
  awk '
     BEGIN { FS="[^a-zA-Z]+" } {
         for (i=1; i<=NF; i++) {
             word = tolower($i)
             words[word]++
         }
     }
     END {
         for (w in words)
              printf("%3d %s\n", words[w], w)
     } ' | sort -rn
}

rm wordcount.txt
cat word_cloud/words.txt | wordfrequency > wordcount.txt
sh txt2cloud.sh -m3 word_cloud/words.txt > cloud.xhtml
mv cloud.xhtml ../../cloud.xhtml
