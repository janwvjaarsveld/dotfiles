#!/usr/bin/env bash

current_dir=$(pwd)
dir=${1:-$pwd}

# we only want to list directories
name="$(ls -l $dir | grep '^d' | awk '{print $9}' | fzf)"

if [ -z "$name" ]; then
	exit 0
fi

cd $dir/$name 
code .
cd $current_dir