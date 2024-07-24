#!/bin/bash
# total-task-time.sh

# This script will calculate the total time spent on a task

timew tags | fzf-tmux | sed 's/ -$//' > /tmp/timebomb-tag.txt
timew summary "`cat /tmp/timebomb-tag.txt`" :week && exit 0 || exit 1


