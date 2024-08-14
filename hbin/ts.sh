#!/usr/bin/zsh
#usr/bin/bash


#
#  Author : Hrutvik Yadav 
#

# unset me_tmp_finalbasedir me_tmp_finalbasedir2 me_tmp_selected me_tmp_target_session
# echo "Info :"
# echo $me_tmp_finalbasedir $me_tmp_finalbasedir2 $me_tmp_selected $me_tmp_target_session
# 
# me_tmp_selected=$(ls ~/work ~/pers/c-projects ~/pers/coursera-snl ~/pers/go-repos/ ~/.config | fzf)
# me_tmp_finalbasedir="$HOME/$((fdfind $me_tmp_selected ~/pers/c-projects -a -q 2> /dev/null && echo "pers/c-projects" )||( fdfind $me_tmp_selected ~/work -a -q 2> /dev/null && echo "work" )||( fdfind $me_tmp_selected ~/pers/coursera-snl -a -q 2> /dev/null && echo "pers/coursera-snl" )||( fdfind $me_tmp_selected ~/pers/go-repos -a -q 2> /dev/null && echo "pers/go-repos")||(fdfind $me_tmp_selected ~/.config -a -q 2> /dev/null && echo ".config" ))"
# 
# echo "Info :"
# echo $me_tmp_finalbasedir $me_tmp_selected $me_tmp_target_session
# 
# tmux ls | grep $me_tmp_selected 2> /dev/null
# if [[ $? -ne 0 ]] # error
# then
#     fdfind $me_tmp_selected $me_tmp_finalbasedir --glob -a -x tmux new -d -s$me_tmp_selected  -c {} 2> /dev/null && echo "New session created !"
# fi

# || (fdfind $me_tmp_selected $me_tmp_finalbasedir -a -x tmux new -d -c {})

# later move to its own bash function?
#me_tmp_target_session=$(tmux ls | awk -F: '{print $1}' | fzf)
#if [[ -z "$me_tmp_target_session" ]]
#then
#    echo "Did not attach !"
#    exit 1
#else
#    tmux attach -t$me_tmp_target_session
#    echo "attaching to $me_tmp_selected"
#    exit 0
#fi

# if inside tmux, then switch client to the session
# else create a new session and attach to it

listcocks=`echo "/home/ria_ari/.config /home/ria_ari/repos /home/ria_ari/repos/c-projects"`

allbases=$(cat <(fd -H '.git$' ~/repos | sed -e 's/.git\///' | awk -F'/' '{print $(NF-1)}') <(ls `echo $listcocks` -l | awk '{print $NF}'))
selectedbases=$(echo $allbases|fzf)


# if nothing selected exit 1
if [[ -z "$selectedbases" ]]
then
    echo "No base selected !"
    exit 1
fi

# selectedbaseloc=$( cat <(echo $allbases) <(ls ~/.config)| xargs -I{} fd {} ~/repos ~/.config -1 --type d --glob -a ) && echo $selectedbaseloc
selectedbaseloc=$(fd $selectedbases ~/repos `echo $listcocks` -1 --type d --glob -a) && echo $selectedbaseloc


if ! tmux has-session -t $selectedbases 2>/dev/null
then
    tmux new -d -s$selectedbases -c $selectedbaseloc 
fi

if [[ -z "$TMUX" ]]
then
    tmux attach -t $selectedbases
else
    tmux switch-client -t $selectedbases
fi
