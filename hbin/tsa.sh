#!/bin/zsh

target=`tmux ls|awk -F: '{print $1}'|fzf-tmux || fzf`
tmux switchc -t $target 2> /dev/null || tmux a -t $target 2> /dev/null

exit 0

