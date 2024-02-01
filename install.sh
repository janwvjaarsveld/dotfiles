#!/usr/bin/env bash

DOTFILES_DIR=$HOME/dotfiles

[ ! -d "${DOTFILES_DIR}" ] && echo "Directory ${DOTFILES_DIR} DOES NOT exists." && exit 1

echo "Setting up development configuration..."

mkdir -p ~/.config

setup_homebrew() {
	echo "Setting up Homebrew..."
	# Install Homebrew
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	UNAME_MACHINE="$(/usr/bin/uname -m)"
	if [[ "${UNAME_MACHINE}" == "arm64" ]]; then

		# On ARM macOS, this script installs to /opt/homebrew only
		HOMEBREW_PREFIX="/opt/homebrew"
		HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
	else
		# On Intel macOS, this script installs to /usr/local only
		HOMEBREW_PREFIX="/usr/local"
		HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
	fi
	(
		echo
		echo 'eval "$('${HOMEBREW_REPOSITORY}'/bin/brew shellenv)"'
	) >>~/.zprofile
	eval "$(${HOMEBREW_REPOSITORY}/bin/brew shellenv)"
}

install_dependencies() {
	echo "Installing dependencies"
	# brew install --cask iterm2
	brew install neovim kitty python3 nvm yarn ripgrep pyenv the_silver_searcher fd lazydocker lazygit git wget curl unzip fontconfig go fzf
}

setup_fonts() {
	brew tap homebrew/cask-fonts
	brew install font-meslo-for-powerline font-meslo-lg-nerd-font
	fc-cache -fv
}

setup_zsh() {
	echo "Setting up zsh..."
	# Install oh-my-zsh
	brew install zsh
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
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

setup_kitty() {
	echo "Setting up kitty..."
	echo "Symlinking $HOME/dotfiles/kitty to ~/.config/"
	ln -sf $DOTFILES_DIR/kitty $HOME/.config/
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

echo "Do you wish to install homebrew?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		setup_homebrew
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

echo "Do you wish to install the dependencies?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		install_dependencies
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

echo "Do you wish to install fonts?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		setup_fonts
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

echo "Do you wish to install neovim?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		setup_nvim
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

echo "Do you wish to install zsh?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		setup_zsh
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

echo "Do you wish to install kitty?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		setup_kitty
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

echo "Do you wish to install tmux?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		setup_tmux
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

echo "Do you wish to install tmuxinator?"
select yns in "Yes" "No" "Skip"; do
	case $yns in
	Yes)
		setup_tmuxinator
		break
		;;
	No) exit ;;
	Skip) break ;;
	esac
done

chmod +x $HOME/dotfiles/scripts/*
echo "Setting up development configuration... DONE"
