#!/bin/bash

tmux send -tNoContext:0.0 "clear && timew summary :ids" enter
tmux send -tNoContext:0.1 "clear && timew day" enter
tmux send -tNoContext:1.0 "clear && task next limit:5" enter
tmux send -tNoContext:1.1 "clear && task summary" enter
tmux send -tNoContext:1.2 "clear && task timesheet" enter
exit 0
