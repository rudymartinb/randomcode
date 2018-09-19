#!/bin/bash

clear
inotifywait -m --format %w%f -q -r -e close_write $1 $2 | \
while read CUAL 
do
	if [ $? == 0 ]; then
		clear
		phpunit.phar --color  $1
   fi
done 

