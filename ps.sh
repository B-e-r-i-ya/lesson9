#!/bin/bash

for pid in $(ls /proc/|awk '{print $1}'|grep -s "^[0-9]*[0-9]$"|sort -n)
do

	tty=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $7}')
	stat=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $3}')
	utime=$(cat 2>/dev/null /proc/$pid/stat | awk '{print $14}')
	stime=$(cat  2>/dev/null /proc/$pid/stat | awk '{print $17}')
	if [ -f "/proc/${pid}/cmdline" ] 
	then 
			IFS= read -d '' test</proc/$pid/cmdline||[[ $test ]]
			cmd=`echo ${test}|awk '{print $1}'`
	fi

	printf "%-8s | %-15s | %s\n" "$pid | $tty | $stat | $time | $cmd" | column -t  -s '|'

done