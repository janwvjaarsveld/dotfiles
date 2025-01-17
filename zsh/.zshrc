# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/jan.willem.van.jaarsveld/.zsh/completions:"* ]]; then export FPATH="/Users/jan.willem.van.jaarsveld/.zsh/completions:$FPATH"; fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ];
then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

plugins=(colorize)

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 light-mode \
  zdharma-continuum/history-search-multi-word \
  Aloxaf/fzf-tab 
  # softmoth/zsh-vim-mode

# Add in snippets
zinit snippet OMZP::fancy-ctrl-z
zinit ice wait lucid snippet OMZP::git
zinit ice wait lucid snippet OMZP::nvm
zinit ice wait lucid snippet OMZP::pyenv
zinit ice wait lucid snippet OMZP::aws
zinit ice wait lucid snippet OMZP::command-not-found

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c="clear"
alias q="exit"
alias nzsh="nvim ~/.zshrc"
alias szsh="source ~/.zshrc"
alias fixlogi="sudo pkill -9 logiopt"
alias serve="python3 -m http.server"
alias pnl="cd ~/postnl"
alias dev="cd ~/dev"
alias tsession='~/dotfiles/tmux/sessions.sh'
alias tpos='tsession ~/postnl "postnl"'
alias tdev='tsession ~/dev "dev"'
alias tdot='tsession ~ "dev" true "dotfiles"'
alias dotfiles='tsession ~ "dev" true "dotfiles"'
# alias python='python3'
# alias pip='pip3'

# Example aliases
alias greset="git fetch && git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias excel="open -a /Applications/Microsoft\ Excel.app"
alias vmrss="~/dotfiles/scripts/vmrss.sh"
alias ta='tmux attach -t'
alias tns='tmux new-session -s'
alias tnw='tmux new-window -n'
alias n='nvim'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
export EDITOR="nvim"
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# UNAME_MACHINE="$(/usr/bin/uname -m)"
# if [[ "${UNAME_MACHINE}" == "arm64" ]];
# then
  # On ARM macOS, this script installs to /opt/homebrew only
  HOMEBREW_PREFIX="/opt/homebrew"
# else
#   # On Intel macOS, this script installs to /usr/local only
#   HOMEBREW_PREFIX="/usr/local"
# fi

# if [[ -f "${HOMEBREW_PREFIX}/bin/brew" ]];
# then
  # If you're using macOS, you'll want this enabled
  # eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
# fi


# npm global
export PATH=~/.npm-global/bin:$PATH
export PATH="${HOMEBREW_PREFIX}/opt/curl/bin:$PATH"
export PATH="${HOMEBREW_PREFIX}/opt/unzip/bin:$PATH"

# add go to PATH
export PATH=$PATH:~/go/bin

# Set to use ruby installed from homebrew
if [ -d "${HOMEBREW_PREFIX}/opt/ruby/bin" ]; then
  export PATH=${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
export ANTHROPIC_API_KEY=$(<~/.api-keys/anthropic.txt)
export OPENAI_API_KEY=$(<~/.api-keys/openai.txt)
# asdf sourcing
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# this is needed for kitty to enable jumping to words with option + arrow keys
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
