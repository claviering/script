#!/bin/bash

rm -rf dist 
mkdir dist
cp *.html dist
cp -r public dist

OS="`uname`"

for i in $( ls  dist)
do
  extName=$( echo $i | cut -d'.' -f2 )
  if [ $extName = "html" ]
  then
    fileName=$( echo $i | cut -d'.' -f1 )
    js="./dist/public/js/"$fileName".js"
    if [ $OS = "Darwin" ]
    then
      fileContentMd5=$( md5 -q $js) # in MaxOs
      mv $js "./dist/public/js/"$fileName".$fileContentMd5.js"
      sed -i "" "s/$fileName\.js/$fileName\.$fileContentMd5\.js/g" dist/$i # in MaxOs
    else
      fileContentMd5=($(md5sum $js)) # in linux
      mv $js "./dist/public/js/"$fileName".$fileContentMd5.js"
      sed -i "s/$fileName\.js/$fileName\.$fileContentMd5\.js/g" dist/$i # in linux
    fi
  fi
done