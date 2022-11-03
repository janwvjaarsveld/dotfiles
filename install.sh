#!/usr/bin/env zsh

for DIR in */; do
	cd $DIR
	files=($(ls -A))
	for file in "${files[@]}"; do
	   ln -sf ~/dotfiles/"$DIR""$file" ~/"$file"
	   echo Symlinking ~/dotfiles/"$DIR""$file" to ~/"$file"
   done
   cd ..
done
