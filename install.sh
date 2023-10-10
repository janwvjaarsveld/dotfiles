#!/usr/bin/env sh

DOTFILES_DIR=$HOME/dotfiles

[ ! -d "${DOTFILES_DIR}" ] && echo "Directory ${DOTFILES_DIR} DOES NOT exists." && exit 1

echo "Setting up development configuration..."

setup_homebrew() {
	echo "Setting up Homebrew..."
	# Install Homebrew
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew cask install iterm2
	brew install neovim python3 nodejs nvm yarn ripgrep pyenv the_silver_searcher fd lazydocker lazygit git wget curl unzip
}

setup_fonts() {
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip -O ~/Downloads/Meslo.zip
	unzip ~/Downloads/Meslo.zip -d ~/Downloads/tmp
	mv ~/Downloads/tmp/*.ttf ~/.local/share/fonts
	rm -rf ~/Downloads/Meslo.zip ~/Downloads/tmp
	fc-cache -fv
}

setup_zsh() {
	echo "Setting up zsh..."
	# Install oh-my-zsh
	brew install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	for FILE in $(ls -A ${DOTFILES_DIR}/zsh); do
		echo "Symlinking $HOME/dotfiles/zsh/$FILE to ~/$FILE"
		ln -sf $DOTFILES_DIR/zsh/"$FILE" $HOME/"$FILE"
	done

	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	# Make ZSH default shell
	chsh -s $(which zsh)
}

setup_nvim() {
	echo "Setting up nvim..."
	echo "Symlinking $HOME/dotfiles/nvim to ~/.config/"
	ln -sf $DOTFILES_DIR/nvim $HOME/.config/
}

setup_tmux() {
	echo "Setting up tmux..."
	brew install tmux
	for FILE in $(ls -A ${DOTFILES_DIR}/tmux); do
		echo "Symlinking $HOME/dotfiles/tmux/$FILE to ~/$FILE"
		ln -sf $DOTFILES_DIR/tmux/"$FILE" $HOME/"$FILE"
	done
}

setup_tmuxinator() {
	echo "Setting up tmuxinator..."
	# Install tmuxinator
	brew install tmuxinator
	echo "Symlinking $DOTFILES_DIR/tmuxinator to ~/.config/"
	ln -sf $DOTFILES_DIR/tmuxinator $HOME/.config/
}

setup_homebrew
setup_fonts
setup_nvim
setup_zsh
setup_tmux
setup_tmuxinator

chmod +x $HOME/dotfiles/scripts/*
echo "Setting up development configuration... DONE"
