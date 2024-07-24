#!/usr/bin/zsh

source ~/.zshrc
clear

greet_on_login
echo "\u276F"
files_worked_on_yesterday | awk -F/ 'BEGIN {print "Here are files modified yesterday...\n>\n"}{print $NF}END{print ">\nContinue editing these? Press [y/n]"}'
read answer
if [ "$answer" = "y" ];then
  selected="$(files_worked_on_yesterday | fzf --header="s some")"
else
  selected=''
fi

echo $selected
if [ -z $selected ]; then
  echo open regular tmux session to browse through directories
else
  file_or_dir=$(file $selected | cut -d ':' -f 2 | tr -d ' ')
  if [ "$file_or_dir" = "directory" ]; then echo start tmux with selected dir
  else echo open tmux session with selected file
  fi
fi
