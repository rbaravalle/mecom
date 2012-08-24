#!/usr/bin/bash

for i in *
do 
convert "./$i" -resize 380x380! "./res/$i"
done 


exit 0
