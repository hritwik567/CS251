#!/usr/bin/bash


if [ $# -ne 1 ]
then
	echo "check usage"
	exit -1
fi

if [ ! -d "$1" ]
then
	echo "$1 not a directory"
	exit -1
fi

dir="$1"
comments=0
strings=0

while read file
do	
	if [ "${file: -2}" == ".c" ]
	then
		output=`awk -f q1.awk "$file"`
		split=(`echo -n $output|tr " " "\n"`)
		comments=$((${split[0]}+comments))
		strings=$((${split[1]}+strings))
	else
		echo "File<$file> extension not .c Skipping!!"
	fi
done< <(find "$dir" -type f)

echo "$comments $strings"
