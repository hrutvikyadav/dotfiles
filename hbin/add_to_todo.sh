#!/bin/bash

sdate=$(date "+%d-%m-%Y")
read -p "Concerned project? : " project
read -p "Task: " task
read -p "Info: " info

echo -e "$sdate,$project,$task,$info"
