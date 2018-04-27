#!/usr/bin/bash

if [ $# -ne 1 ]
then
printf "usage: $0 <number>"
	exit -1
fi

if [[ ! -f $1 ]]
then
printf "Not a file\n"
	exit -1
fi

flagd=0
flagf=0
l=""

while read -N1 c
do
	l="$l$c"

	if [[ "$l" =~ [\ \t\n]*(<dir>)[\ ]* ]]
	then
		l=""
		((flagd++))

	elif [[ "$l" =~ [\ \t\n]*(<\/dir>)[\ ]* ]]
	then
		l=""
		((flagd--))
		cd ..

	elif [[ "$l" =~ [\ \t\n]*(<file>)[\ ]* ]]
	then
		l=""
		flagf=1

	elif [[ "$l" =~ [\ \t\n]*(<\/file>)[\ ]* ]]
	then
		l=""
		flagf=0

	elif [[ "$l" =~ [\ \t\n]*(<name>)[^\<]*(<\/name>)[\ ]* ]]
	then
		l=`printf "$l" | xargs`
		if [ $flagf -eq 1 ]
		then
			fname=`printf "$l"  | sed 's/<[^<]*>//g'`
			fname=`printf "$fname" | sed  's/^[ \t\n]*//;s/[ \t\n]*$//'`
		else
			dname=`printf "$l"  | sed  's/<[^<]*>//g'`
			dname=`printf "$dname" | sed  's/^[ \t\n]*//;s/[ \t\n]*$//'`
			mkdir "$dname"
			cd "$dname"
		fi
		l=""
	elif [[ "$l" =~ [\ \t\n]*(<size>)[0-9\ ]*(<\/size>)[\ ]* ]]
	then
		l=`printf "$l" | xargs`
		fsize=`printf "$l"  | sed 's/<[^<]*>//g'`
		fsize=`printf "$fsize" | sed 's/^[ \t]*//;s/[ \t]*$//'`
		fallocate -l $fsize "$fname"
		l=""
	fi
done < "$1"
