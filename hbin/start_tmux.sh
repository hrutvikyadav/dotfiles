#!/bin/bash

echo "Go ahead!"
start_tmux(){
  # new named session in detached mode, so that we can continue sending commands from shell
  S_NAME=$(tmux new -d -s "$DIRECTORY" -c $DIRECTORY -F\#S)
  tmux rename-window -t$S_NAME: "Code Editor"
  PANE_1_ID=$(tmux lsp -F'#{pane_id}' -t"$S_NAME:")

  # cd to desired dir, where your main repos are present
  #tmux send-keys "cd $DIRECTORY" C-m

  # run fzf to fuzzy find all files except .git files, and open in nvim as needed
  #tmux send-keys "fdfind --type f --hidden --exclude .git | fzf-tmux --header='Select file to open in Editor' -p --reverse | xargs nvim" C-m
  tmux send-keys -t"$S_NAME:.$PANE_1_ID" "nvim ." C-m

  # Split the window horizontally
  PANE_2_ID=$(tmux split-window -t$S_NAME:. -hPF '#{pane_id}')

  # Send a command to the new pane
  tmux send-keys -t"$S_NAME:.$PANE_2_ID" "git status" C-m

  W2=$(tmux neww -dPt"$S_NAME:" -F'#{window_id}' -n"Cheatsheet" -c$DIRECTORY)

  tmux send-keys -t"$S_NAME:$W2" 'cheat_script.sh' C-l

  # Switch back to the original pane
  tmux select-pane -t"$S_NAME:.$PANE_1_ID"

  # without a target, attaches to the last active session (The one created above)
  tmux attach -t $S_NAME:

  tmux lsw -t"$S_NAME:" -F'#{window_id}= #{window_name}'
  echo $PANE_1_ID $PANE_2_ID $W2
}

SESSION_NAME="Nvim+fzf"
if [ -z $1 ]; then 
  echo 'No arg, default behaviour';
#  exit
else
  echo "Selected dir: $1";
  DIRECTORY=$1
  start_tmux 
  exit
fi
# choose parent dir
pdir=$(echo -e "w-repos\nwork\npers/playground" | fzf --header='Select Parent Directory' --preview 'tree -rdDc -L 2 {}') 

# full path for work dir
#DIRECTORY=$(fdfind --type d . 'work' | fzf)

# case statement for depth
case $pdir in
  "w-repos")
    depth=1
    ;;
  "work")
    depth=2
    ;;
  "pers/playground")
    depth=3
    ;;
  *)
    depth=2
    echo -n "Invalid"
    exit 1
    ;;
esac

# filter dir by modification time
selected=$(echo -e "Recent\nOlder\nAll" | fzf --header='Browse by modification time')
if [ $selected == "Recent" ]
then
  DIRECTORY=$(fdfind --type d -d $depth . ~/"$pdir" --changed-within=7days | fzf --header='Select git repo to open' --preview "tree -rdDc -L $depth {}")
  if [ -z "$DIRECTORY" ];then exit 1;else start_tmux; fi;
elif [ $selected == "Older" ]
then
  DIRECTORY=$(fdfind --type d -d $depth . ~/"$pdir" --changed-before=7days | fzf --header='Select git repo to open' --preview "tree -rdDc -L $depth {}")
  if [ -z "$DIRECTORY" ];then exit 1;else start_tmux; fi;
elif [ $selected == "All" ]; then
  DIRECTORY=$(fdfind --type d . -d $depth "$pdir" | fzf --header='Select git repo to open' --preview "tree -rdDc -L $depth {}")
  if [ -z "$DIRECTORY" ];then exit 1;else start_tmux; fi;
else
  echo "No selection"
  exit 1
fi

exit 0
