#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

sdate=$(date "+%d-%m-%Y")
project=$(echo -e "MitsX\nDataWatcherWeb\nGeneral\nTraining" | fzf --header="Select a PROJECT to enter a RECORD for")
#read -p 'Project: ' project
read -p 'Remarks: ' remarks
read -p 'Work done: ' work_done
read -p 'Status: ' status

last_mod_date=$(stat -c %y ~/Hrutvik_23.csv | cut -d ' ' -f 1 | cut -d '-' -f 3)
last_mod_month=$(stat -c %y ~/Hrutvik_23.csv | cut -d ' ' -f 1 | cut -d '-' -f 2)
curr_date=$(date "+%d")
curr_month=$(date "+%m")

if [ "$last_mod_month" = "$curr_month" ] ; then echo 'no new headers'
else echo 'append heaeders first'
fi

if [ "$last_mod_date" = "$curr_date" ] ; then echo '-'
else echo "put date"
fi

echo -e "$sdate,$project,$(echo $remarks | tr ',' '|'),$(echo $work_done | tr ',' '|'),$(echo $status | tr ',' '|')" >> ~/Hrutvik_23.csv

if [ $? -eq 0 ]; then echo -ne "${GREEN}Done${NC}"; exit 0
else echo -ne "${RED}Failed${NC}"; exit 1
fi
