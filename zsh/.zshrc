# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=30
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
)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export JAVA_HOME=/opt/homebrew/Cellar/openjdk@11/11.0.16.1_1/libexec/openjdk.jdk/Contents/Home
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# My useful aliases
alias c="clear"
alias q="exit"
alias zsh="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias vimrc='vim ~/.vimrc'
alias szsh="source ~/.zshrc"
alias fixlogi="sudo pkill -9 logiopt"
alias tmux-session="~/dotfiles/tmux/create-tmux-session.sh"

# Example aliases
alias IAGRPF="cd ~/Development/projects/IAGL/reward-platform"
alias TXIAGRPF="tmux-session reward-platform ~/Development/projects/IAGL/reward-platform"
alias IAGFAB="cd ~/Development/projects/IAGL/redemption-flight-availability-service"
alias TXIAGFAB="tmux-session redemption-flight-availability-service ~/Development/projects/IAGL/redemption-flight-availability-service"
alias IAGLOC="cd ~/Development/projects/IAGL/redemption-locations-service"
alias TXIAGLOC="tmux-session redemption-locations-service ~/Development/projects/IAGL/redemption-locations-service"
alias IAGLOCINFRA="cd ~/Development/projects/IAGL/redemption-locations-infrastructure"
alias TXIAGLOCINFRA="tmux-session redemption-locations-infrastructure ~/Development/projects/IAGL/redemption-locations-infrastructure"
alias IAGTFC="cd ~/Development/projects/IAGL/redemption-flight-tax-fees-charges-service"
alias TXIAGTFC="tmux-session redemption-flight-tax-fees-charges-service ~/Development/projects/IAGL/redemption-flight-tax-fees-charges-service"
alias IAGLOCEXTRACT="cd ~/Development/projects/IAGL/redemption-oag-data-extractor"
alias TXIAGLOCEXTRACT="tmux-session redemption-oag-data-extractor ~/Development/projects/IAGL/redemption-oag-data-extractor"
alias TXIAGFABINFRA="tmux-session redemption-availability-infrastructure ~/Development/projects/IAGL/redemption-availability-infrastructure"
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
