#!/bin/sh
should_process=true
ARG_SPLIT_SIZE=$3
DEFUALT_SPLIT_SIZE=30
SPLIT_SIZE="${ARG_SPLIT_SIZE:=$DEFUALT_SPLIT_SIZE}"
if [ -z "$1" ];
then
  echo "missing NAME parameter";
  should_process=false
fi

if [ -z "$2" ];
then
  echo "missing PATH parameter";
  should_process=false
fi

if $should_process;
then
  tmux new -s $1 -c $2 'nvim \":NvimTreeToggle\"' \; \
    split-window -h -p $SPLIT_SIZE \; \
    select-pane -t 1 || \
  tmux a -t $1
fi
