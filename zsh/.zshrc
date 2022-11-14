export ZSH="$HOME/.oh-my-zsh"
# Use spaceship theme
ZSH_THEME="spaceship"
autoload -U promptinit; promptinit
export UPDATE_ZSH_DAYS=30

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

SPACESHIP_PROMPT_ORDER=(
  user
  host
  dir
  git
  node
  java
  golang
  terraform
  docker
  line_sep
  char
  )

SPACESHIP_RPROMPT_ORDER=(
  time
  )

   # TIME
   SPACESHIP_TIME_SHOW=true
   SPACESHIP_TIME_PREFIX=" --------- "
   SPACESHIP_TIME_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_TIME_FORMAT='%D{%H:%M:%S.%.}'
   SPACESHIP_TIME_12HR=false
   SPACESHIP_TIME_COLOR="yellow"
   # USER
   SPACESHIP_USER_SHOW=true
   SPACESHIP_USER_PREFIX=" with "
   SPACESHIP_USER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_USER_COLOR="yellow"
   SPACESHIP_USER_COLOR_ROOT="red"
   # HOST
   SPACESHIP_HOST_SHOW=true
   SPACESHIP_HOST_PREFIX=" at "
   SPACESHIP_HOST_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_HOST_COLOR="green"
   # DIR
   SPACESHIP_DIR_SHOW=true
   SPACESHIP_DIR_PREFIX=" in "
   SPACESHIP_DIR_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_DIR_TRUNC=3
   SPACESHIP_DIR_COLOR="cyan"
   # JAVA
   SPACESHIP_JAVA_SHOW=true
   SPACESHIP_JAVA_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
   SPACESHIP_JAVA_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_JAVA_SYMBOL="☕️ "
   SPACESHIP_JAVA_COLOR="cyan"
   # GIT
   SPACESHIP_GIT_SHOW=true
   SPACESHIP_GIT_PREFIX=" on "
   SPACESHIP_GIT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_GIT_SYMBOL=" "
   # GIT BRANCH
   SPACESHIP_GIT_BRANCH_SHOW=true
   SPACESHIP_GIT_BRANCH_PREFIX="$SPACESHIP_GIT_SYMBOL"
   SPACESHIP_GIT_BRANCH_SUFFIX=""
   SPACESHIP_GIT_BRANCH_COLOR="magenta"
   # GIT STATUS
   SPACESHIP_GIT_STATUS_SHOW=true
   SPACESHIP_GIT_STATUS_PREFIX=" ["
   SPACESHIP_GIT_STATUS_SUFFIX="]"
   SPACESHIP_GIT_STATUS_COLOR="red"
   SPACESHIP_GIT_STATUS_UNTRACKED="?"
   SPACESHIP_GIT_STATUS_ADDED="+"
   SPACESHIP_GIT_STATUS_MODIFIED="!"
   SPACESHIP_GIT_STATUS_RENAMED="»"
   SPACESHIP_GIT_STATUS_DELETED="✘"
   SPACESHIP_GIT_STATUS_STASHED="$"
   SPACESHIP_GIT_STATUS_UNMERGED="="
   SPACESHIP_GIT_STATUS_AHEAD="⇡"
   SPACESHIP_GIT_STATUS_BEHIND="⇣"
   SPACESHIP_GIT_STATUS_DIVERGED="⇕"
   # NODE
   SPACESHIP_NODE_SHOW=true
   SPACESHIP_NODE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
   SPACESHIP_NODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_NODE_SYMBOL="⬢ "
   SPACESHIP_NODE_DEFAULT_VERSION=""
   SPACESHIP_NODE_COLOR="green"
   PACESHIP_RUBY_COLOR="red"
   PACESHIP_SWIFT_COLOR="yellow"
   # GOLANG
   SPACESHIP_GOLANG_SHOW=true
   SPACESHIP_GOLANG_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
   SPACESHIP_GOLANG_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_GOLANG_SYMBOL="🐹 "
   SPACESHIP_GOLANG_COLOR="cyan"
   PACESHIP_RUST_COLOR="red"
   # DOCKER
   SPACESHIP_DOCKER_SHOW=true
   SPACESHIP_DOCKER_PREFIX=" on "
   SPACESHIP_DOCKER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_DOCKER_SYMBOL="🐳 "
   SPACESHIP_DOCKER_COLOR="cyan"
   # VENV
   SPACESHIP_VENV_SHOW=true
   SPACESHIP_VENV_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
   SPACESHIP_VENV_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   PACESHIP_VENV_COLOR="blue"
   # PYENV
   SPACESHIP_PYTHON_SHOW=true
   SPACESHIP_PYTHON_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
   SPACESHIP_PYTHON_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_PYTHON_SYMBOL="🐍 "
   SPACESHIP_PYTHON_COLOR="yellow"
   # VI_MODE
   SPACESHIP_VI_MODE_SHOW=true
   SPACESHIP_VI_MODE_PREFIX=""
   SPACESHIP_VI_MODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_VI_MODE_INSERT="[I]"
   SPACESHIP_VI_MODE_NORMAL="[N]"
   SPACESHIP_VI_MODE_COLOR="white"
   # TERRAFORM
   SPACESHIP_TERRAFORM_SHOW=true
   SPACESHIP_TERRAFORM_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"
   SPACESHIP_TERRAFORM_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"
   SPACESHIP_TERRAFORM_SYMBOL="🛠️ "
   SPACESHIP_TERRAFORM_COLOR=105
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

# Example aliases
alias IAGRPF="cd ~/Development/projects/IAGL/reward-platform"
alias TXIAGRPF="tmux new -s reward-platform -c ~/Development/projects/IAGL/reward-platform || tmux a -t reward-platform"
alias IAGFAB="cd ~/Development/projects/IAGL/redemption-flight-availability-service"
alias TXIAGFAB="tmux new -s redemption-flight-availability-service -c ~/Development/projects/IAGL/redemption-flight-availability-service || tmux a -t redemption-flight-availability-service"
alias IAGLOC="cd ~/Development/projects/IAGL/redemption-locations-service"
alias TXIAGLOC="tmux new -s redemption-locations-service -c ~/Development/projects/IAGL/redemption-locations-service || tmux a -t redemption-locations-service"
alias IAGLOCINFRA="cd ~/Development/projects/IAGL/redemption-locations-infrastructure"
alias TXIAGLOCINFRA="tmux new -s redemption-locations-infrastructure -c ~/Development/projects/IAGL/redemption-locations-infrastructure || tmux a -t redemption-locations-infrastructure"
alias IAGTFC="cd ~/Development/projects/IAGL/redemption-flight-tax-fees-charges-service"
alias TXIAGTFC="tmux new -s redemption-flight-tax-fees-charges-service -c ~/Development/projects/IAGL/redemption-flight-tax-fees-charges-service || tmux a -t redemption-flight-tax-fees-charges-service"
alias IAGLOCEXTRACT="cd ~/Development/projects/IAGL/redemption-oag-data-extractor"
alias TXIAGLOCEXTRACT="tmux new -s redemption-oag-data-extractor -c ~/Development/projects/IAGL/redemption-oag-data-extractor || tmux a -t redemption-oag-data-extractor"
alias TXIAGFABINFRA="tmux new -s redemption-availability-infrastructure -c ~/Development/projects/IAGL/redemption-availability-infrastructure || tmux a -t redemption-availability-infrastructure"
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
