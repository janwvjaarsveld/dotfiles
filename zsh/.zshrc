# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=30
export EDITOR="nvim"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable autocorrection
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  npm
  bundler
  zsh-syntax-highlighting
  brew
  macos
  zsh-autosuggestions
  colored-man-pages
  colorize
  web-search
)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# My useful aliases
alias c="clear"
alias q="exit"
alias zsh="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias vimrc='nvim ~/.vimrc'
alias szsh="source ~/.zshrc"
alias fixlogi="sudo pkill -9 logiopt"
alias serve="python3 -m http.server"

# Example aliases
alias greset="git fetch && git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias gst="git status"
alias gss="git stash"
alias gsp="git stash pop"
alias excel="open -a /Applications/Microsoft\ Excel.app"
alias lvim="~/.local/bin/lvim"
alias vmrss="~/dotfiles/scripts/vmrss.sh"
alias ta='tmux attach -t'
alias tns='tmux new-session -s'
alias n='nvim'

bindkey -v
# npm global
export PATH=~/.npm-global/bin:$PATH
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/unzip/bin:$PATH"

[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set to use ruby installed from homebrew
if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
