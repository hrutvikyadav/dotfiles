#!/bin/bash

# Prompt the user to select what to search
action=$(echo -e "Language\nCore Util" | fzf --layout=reverse)

if [ "$action" == "Language" ]; then
  # Prompt the user to select a language
  language=$(echo -e "ruby\nrust\nbash\nc\njs" | fzf --layout=reverse)
  
  # List the available cheat sheets for the selected language/technology and prompt the user to select a query
  query=$(cht.sh "$language" :list | fzf --layout=reverse --header='Choose from list of available sheets or press Esc to enter a custom query')
  
  # If the user didn't select anything, prompt them to learn the language or enter a custom query
  if [ -z "$query" ]; then
    action=$(echo -e "Learn\nCustom Query" | fzf --layout=reverse)
    
    if [ "$action" == "Learn" ]; then
      query=":learn"
    elif [ "$action" == "Custom Query" ]; then
      echo "Please enter your query:"
      read query
    else
      exit 0
    fi
  fi
elif [ "$action" == "Core Util" ]; then
  # Prompt the user to select a core util
  util=$(echo -e "grep\ntar\nsed\nfind" | fzf --layout=reverse --header='Select one from above or press Esc to search a custom Util')
  
  if [ -z "$util" ];then
    read -p "Enter a core util: " util
  fi
  # List the available cheat sheets for the selected core util and prompt the user to select a query
  echo "Please select a query:"
  read query
else
  exit 0
fi

# Execute the cht.sh command with the selected language/technology/core util and the selected or custom query
cht.sh "$language/$util" "$query"
