#!/usr/bin/env zsh

file_list=(".vimrc" ".zshrc" ".vim" ".tmux.conf" ".tmux")
for file in $file_list; do
	   ln -sf ~/dotfiles/"$file" ~/"$file"
	   echo $file
done
