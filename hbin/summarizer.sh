#!/bin/bash

dr=$(date_regex.sh)

cat ~/Hrutvik_23.csv | rg -e "$dr" | awk -F, 'BEGIN{print "-----This weeks summary-----\n"};{print $2,$NF,$4};END{print "\n---end---"}'

