#!/bin/bash

for pid in $(ls /proc/|awk '{print $1}'|grep -s "^[0-9]*[0-9]$"|sort -n)
do

	tty=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $7}')
	stat=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $3}')
	time=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $14}')
	stime=$(cat  2>/dev/null /proc/$pid/stat | awk '{print $17}')
	
	if [ -f "/proc/${pid}/cmdline" ] 
	then 
			IFS= read -d '' cmd</proc/$pid/cmdline||[[ $cmd ]]
			cmd=`echo ${cmd}|awk '{print $1}'`
			
	fi
	RED='\033[0;31m'
	YELLOW='\033[0;33m'
	BLUE='\033[0;34m'
	NORM='\033[0m'
	echo -e "| $pid | $YELLOW $tty $NORM| $RED $stat $NORM| $time | $BLUE $cmd $NORM"|column -t -s '|' -n

done
