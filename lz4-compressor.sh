#!/bin/bash

cd "$1"
temp=`mktemp`
dir -1 -A "$1" > "$temp"

while IFS= read -r file
do
    if [ -d "$file" ]
    then
	echo "Subdirectory found, spawning new process"
	/root/comp-lz4.sh "$1"/"$file"
    else
	lz4 -9 --rm -f "$file"
	#rm "$file.lz4"
    fi
done < "$temp"
