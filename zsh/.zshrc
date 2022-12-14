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

export JAVA_HOME=/opt/homebrew/Cellar/openjdk@11/11.0.17/libexec/openjdk.jdk/Contents/Home
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
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

# Example aliases
alias IAGRPF="cd ~/Development/projects/IAGL/reward-platform"
alias TXIAGRPF="tmuxinator default ~/Development/projects/IAGL/reward-platform"
alias IAGFAB="cd ~/Development/projects/IAGL/redemption-flight-availability-service"
alias TXIAGFAB="tmuxinator default ~/Development/projects/IAGL/redemption-flight-availability-service"
alias IAGLOC="cd ~/Development/projects/IAGL/redemption-locations-service"
alias TXIAGLOC="tmuxinator default ~/Development/projects/IAGL/redemption-locations-service"
alias IAGLOCINFRA="cd ~/Development/projects/IAGL/redemption-locations-infrastructure"
alias TXIAGLOCINFRA="tmuxinator default ~/Development/projects/IAGL/redemption-locations-infrastructure"
alias IAGTFC="cd ~/Development/projects/IAGL/redemption-flight-tax-fees-charges-service"
alias TXIAGTFC="tmuxinator default ~/Development/projects/IAGL/redemption-flight-tax-fees-charges-service"
alias IAGLOCEXTRACT="cd ~/Development/projects/IAGL/redemption-oag-data-extractor"
alias TXIAGLOCEXTRACT="tmuxinator default ~/Development/projects/IAGL/redemption-oag-data-extractor"
alias TXIAGFABINFRA="tmuxinator default ~/Development/projects/IAGL/redemption-availability-infrastructure"
alias greset="git fetch && git reset --hard origin/\$(git rev-parse --abbrev-ref HEAD)"
alias gst="git status"
alias gss="git stash"
alias gsp="git stash pop"

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
