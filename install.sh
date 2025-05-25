#!/bin/bash

# Bash 3.x compatible interactive installer
set -e

# Terminal colors and formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# Simple characters that work everywhere
CHECK='*'
CROSS=' '
ARROW='>'

DOTFILES_DIR=$HOME/dotfiles

# Component data - using space-separated strings for bash 3 compatibility
COMPONENTS="homebrew dependencies fonts zsh kitty wezterm ghostty neovim tmux tmuxinator raycast amethyst"

# Descriptions (parallel arrays)
DESCRIPTIONS=(
  "Install Homebrew package manager"
  "Install development dependencies (git, curl, etc)"
  "Install Powerline and Nerd fonts"
  "Setup Zsh with Oh My Zsh and plugins"
  "Install and configure Kitty terminal"
  "Install and configure WezTerm terminal"
  "Install and configure Ghostty terminal"
  "Setup Neovim configuration"
  "Setup tmux configuration"
  "Setup tmuxinator session manager"
  "Install Raycast launcher"
  "Install Amethyst window manager"
)

# Categories (parallel arrays)
CATEGORIES=(
  "core"
  "core"
  "core"
  "shell"
  "terminal"
  "terminal"
  "terminal"
  "dev"
  "dev"
  "dev"
  "apps"
  "apps"
)

# Selection state (1=selected, 0=not selected)
SELECTIONS="1 1 1 1 0 0 0 1 1 0 0 0"

# Menu state
CURSOR_POS=0
MENU_ITEMS=""
MENU_COUNT=0

# Convert components string to array
get_component_array() {
  echo $COMPONENTS
}

# Get component by index
get_component() {
  local index=$1
  local count=0
  for comp in $COMPONENTS; do
    if [ $count -eq $index ]; then
      echo $comp
      return
    fi
    count=$((count + 1))
  done
}

# Get component index by name
get_component_index() {
  local name=$1
  local count=0
  for comp in $COMPONENTS; do
    if [ "$comp" = "$name" ]; then
      echo $count
      return
    fi
    count=$((count + 1))
  done
  echo -1
}

# Get selection state for component index
get_selection() {
  local index=$1
  local count=0
  for sel in $SELECTIONS; do
    if [ $count -eq $index ]; then
      echo $sel
      return
    fi
    count=$((count + 1))
  done
  echo 0
}

# Set selection state for component index
set_selection() {
  local index=$1
  local value=$2
  local new_selections=""
  local count=0

  for sel in $SELECTIONS; do
    if [ $count -eq $index ]; then
      new_selections="$new_selections$value"
    else
      new_selections="$new_selections$sel"
    fi
    if [ $count -lt 11 ]; then
      new_selections="$new_selections "
    fi
    count=$((count + 1))
  done

  SELECTIONS="$new_selections"
}

# Toggle selection for component index
toggle_selection() {
  local index=$1
  local current=$(get_selection $index)
  if [ "$current" = "1" ]; then
    set_selection $index 0
  else
    set_selection $index 1
  fi
}

# Clear screen and hide cursor
init_display() {
  clear
  # Try to hide cursor, but don't fail if not supported
  printf '\033[?25l' 2>/dev/null || true
}

# Show cursor and cleanup
cleanup_display() {
  # Try to show cursor, but don't fail if not supported
  printf '\033[?25h' 2>/dev/null || true
  echo ""
}

# Trap to ensure cleanup on exit
trap cleanup_display EXIT

# Move cursor to position (row, col)
move_cursor() {
  local row=$1
  local col=$2
  printf '\033[%d;%dH' $row $col
}

# Draw the header
draw_header() {
  move_cursor 1 1
  echo -e "${BOLD}${BLUE}================================================================================${NC}"
  echo -e "${BOLD}${BLUE}                    Development Environment Installer                       ${NC}"
  echo -e "${BOLD}${BLUE}================================================================================${NC}"
  echo ""
}

# Draw category header
draw_category_header() {
  local category=$1

  case "$category" in
  "core") echo -e "${BOLD}${CYAN}  Core Tools${NC}" ;;
  "shell") echo -e "${BOLD}${CYAN}  Shell & Terminal${NC}" ;;
  "terminal") echo -e "${BOLD}${CYAN}  Terminal Emulators${NC}" ;;
  "dev") echo -e "${BOLD}${CYAN}  Development Tools${NC}" ;;
  "apps") echo -e "${BOLD}${CYAN}  Desktop Applications${NC}" ;;
  "presets") echo -e "${BOLD}${CYAN}  Quick Presets${NC}" ;;
  esac
}

# Draw a component item
draw_component() {
  local index=$1
  local is_cursor=$2

  local component=$(get_component $index)
  local desc="${DESCRIPTIONS[$index]}"
  local selected=$(get_selection $index)

  local status_char="$CROSS"
  local status_color="$RED"

  if [ "$selected" = "1" ]; then
    status_char="$CHECK"
    status_color="$GREEN"
  fi

  if [ "$is_cursor" = "1" ]; then
    echo -e "${BOLD}${YELLOW}$ARROW ${status_color}[$status_char]${NC} ${BOLD}$desc${NC}"
  else
    echo -e "  ${status_color}[$status_char]${NC} $desc"
  fi
}

# Draw preset option
draw_preset() {
  local preset_name=$1
  local preset_desc=$2
  local is_cursor=$3

  if [ "$is_cursor" = "1" ]; then
    echo -e "${BOLD}${YELLOW}$ARROW ${CYAN}[PRESET]${NC} ${BOLD}$preset_desc${NC}"
  else
    echo -e "  ${CYAN}[PRESET]${NC} $preset_desc"
  fi
}

# Draw action button
draw_action() {
  local action=$1
  local is_cursor=$2

  case "$action" in
  "install")
    if [ "$is_cursor" = "1" ]; then
      echo -e "${BOLD}${YELLOW}$ARROW ${GREEN}[INSTALL] Start Installation${NC}"
    else
      echo -e "  ${GREEN}[INSTALL] Start Installation${NC}"
    fi
    ;;
  "quit")
    if [ "$is_cursor" = "1" ]; then
      echo -e "${BOLD}${YELLOW}$ARROW ${RED}[EXIT] Quit${NC}"
    else
      echo -e "  ${RED}[EXIT] Quit${NC}"
    fi
    ;;
  esac
}

# Draw separator
draw_separator() {
  echo -e "  ${DIM}----------------------------------------------------------------${NC}"
}

# Build the menu structure
build_menu() {
  # Build menu items list (space-separated)
  MENU_ITEMS=""
  MENU_COUNT=0

  # Group components by category
  for category in "core" "shell" "terminal" "dev" "apps"; do
    # Add category header
    MENU_ITEMS="$MENU_ITEMS CATEGORY:$category"
    MENU_COUNT=$((MENU_COUNT + 1))

    # Add components in this category
    local index=0
    for comp in $COMPONENTS; do
      if [ "${CATEGORIES[$index]}" = "$category" ]; then
        MENU_ITEMS="$MENU_ITEMS COMPONENT:$index"
        MENU_COUNT=$((MENU_COUNT + 1))
      fi
      index=$((index + 1))
    done

    # Add separator (except after last category)
    if [ "$category" != "apps" ]; then
      MENU_ITEMS="$MENU_ITEMS SEPARATOR"
      MENU_COUNT=$((MENU_COUNT + 1))
    fi
  done

  # Add presets section
  MENU_ITEMS="$MENU_ITEMS SEPARATOR CATEGORY:presets"
  MENU_ITEMS="$MENU_ITEMS PRESET:minimal PRESET:developer PRESET:complete"
  MENU_COUNT=$((MENU_COUNT + 6))

  # Add actions
  MENU_ITEMS="$MENU_ITEMS SEPARATOR ACTION:install ACTION:quit"
  MENU_COUNT=$((MENU_COUNT + 3))
}

# Get menu item by index
get_menu_item() {
  local target_index=$1
  local current_index=0

  for item in $MENU_ITEMS; do
    if [ $current_index -eq $target_index ]; then
      echo "$item"
      return
    fi
    current_index=$((current_index + 1))
  done
}

# Check if menu item is interactive
is_interactive() {
  local item=$1
  case "$item" in
  COMPONENT:* | PRESET:* | ACTION:*) return 0 ;;
  *) return 1 ;;
  esac
}

# Draw the complete menu
draw_menu() {
  clear
  draw_header

  local row=6
  local menu_index=0

  for item in $MENU_ITEMS; do
    move_cursor $row 4

    local is_cursor=0
    [ $menu_index -eq $CURSOR_POS ] && is_cursor=1

    case "$item" in
    CATEGORY:*)
      local category="${item#CATEGORY:}"
      draw_category_header "$category"
      ;;
    COMPONENT:*)
      local comp_index="${item#COMPONENT:}"
      draw_component $comp_index $is_cursor
      ;;
    PRESET:*)
      local preset="${item#PRESET:}"
      case "$preset" in
      "minimal") draw_preset "$preset" "Minimal setup (core tools only)" $is_cursor ;;
      "developer") draw_preset "$preset" "Developer setup (core + dev tools)" $is_cursor ;;
      "complete") draw_preset "$preset" "Complete setup (everything)" $is_cursor ;;
      esac
      ;;
    ACTION:*)
      local action="${item#ACTION:}"
      draw_action "$action" $is_cursor
      ;;
    SEPARATOR)
      draw_separator
      ;;
    esac

    row=$((row + 1))
    menu_index=$((menu_index + 1))
  done

  # Draw footer
  row=$((row + 2))
  move_cursor $row 4
  echo -e "${DIM}Use ${BOLD}j/k or ↑/↓${NC}${DIM} to navigate, ${BOLD}SPACE${NC}${DIM} to toggle, ${BOLD}ENTER${NC}${DIM} to select${NC}"
  row=$((row + 1))
  move_cursor $row 4
  echo -e "${DIM}${BOLD}q${NC}${DIM} to quit, ${BOLD}r${NC}${DIM} to reset selections${NC}"
}

# Navigate through menu
navigate() {
  local direction=$1

  if [ "$direction" = "up" ]; then
    # Move up and skip non-interactive items
    while true; do
      if [ $CURSOR_POS -gt 0 ]; then
        CURSOR_POS=$((CURSOR_POS - 1))
        local item=$(get_menu_item $CURSOR_POS)
        if is_interactive "$item"; then
          break
        fi
      else
        CURSOR_POS=$((MENU_COUNT - 1))
      fi
    done
  elif [ "$direction" = "down" ]; then
    # Move down and skip non-interactive items
    while true; do
      if [ $CURSOR_POS -lt $((MENU_COUNT - 1)) ]; then
        CURSOR_POS=$((CURSOR_POS + 1))
        local item=$(get_menu_item $CURSOR_POS)
        if is_interactive "$item"; then
          break
        fi
      else
        CURSOR_POS=0
      fi
    done
  fi
}

# Handle key input
handle_key() {
  local key="$1"

  case "$key" in
  # Navigation keys
  'k' | 'A') navigate "up" ;;   # k or up arrow
  'j' | 'B') navigate "down" ;; # j or down arrow

  # Action keys
  ' ') toggle_current_item ;; # space
  '') handle_selection ;;     # enter
  'q' | 'Q')
    cleanup_display
    echo "Installation cancelled."
    exit 0
    ;;
  'r' | 'R') reset_selections ;;
  esac
}

# Toggle current item
toggle_current_item() {
  local item=$(get_menu_item $CURSOR_POS)

  case "$item" in
  COMPONENT:*)
    local comp_index="${item#COMPONENT:}"
    toggle_selection $comp_index
    ;;
  esac
}

# Handle selection (Enter key)
handle_selection() {
  local item=$(get_menu_item $CURSOR_POS)

  case "$item" in
  PRESET:*)
    local preset="${item#PRESET:}"
    apply_preset "$preset"
    ;;
  ACTION:*)
    local action="${item#ACTION:}"
    case "$action" in
    "install") start_installation ;;
    "quit")
      cleanup_display
      echo "Installation cancelled."
      exit 0
      ;;
    esac
    ;;
  COMPONENT:*)
    toggle_current_item
    ;;
  esac
}

# Apply preset configuration
apply_preset() {
  local preset="$1"

  # Reset all selections to 0
  SELECTIONS="0 0 0 0 0 0 0 0 0 0 0 0"

  # Define components for each preset
  local components=""
  case "$preset" in
  "minimal")
    components="homebrew dependencies zsh neovim"
    ;;
  "developer")
    components="homebrew dependencies fonts zsh neovim tmux tmuxinator"
    ;;
  "complete")
    components="homebrew dependencies fonts zsh kitty neovim tmux tmuxinator raycast amethyst"
    ;;
  esac

  # Enable selected components
  for comp_name in $components; do
    local index=$(get_component_index "$comp_name")
    if [ $index -ge 0 ]; then
      set_selection $index 1
    fi
  done
}

# Reset selections to defaults
reset_selections() {
  SELECTIONS="1 1 1 1 0 0 0 1 1 0 0 0"
}

# Start installation process
start_installation() {
  cleanup_display

  echo -e "${BOLD}${GREEN}Installation Summary:${NC}"
  echo "===================="

  # Count selected components
  local selected_count=0
  local index=0
  for sel in $SELECTIONS; do
    if [ "$sel" = "1" ]; then
      selected_count=$((selected_count + 1))
    fi
    index=$((index + 1))
  done

  if [ $selected_count -eq 0 ]; then
    echo -e "${YELLOW}No components selected for installation.${NC}"
    exit 0
  fi

  echo "The following components will be installed:"

  # Show selected components
  index=0
  for sel in $SELECTIONS; do
    if [ "$sel" = "1" ]; then
      local comp=$(get_component $index)
      local desc="${DESCRIPTIONS[$index]}"
      echo -e "  ${GREEN}$CHECK${NC} $desc"
    fi
    index=$((index + 1))
  done

  echo ""
  printf "Proceed with installation? (y/N/b): "
  read -r reply

  case "$reply" in
  [Yy] | [Yy][Ee][Ss])
    echo -e "\n${BOLD}${GREEN}Starting installation...${NC}"

    # Install selected components
    index=0
    for sel in $SELECTIONS; do
      if [ "$sel" = "1" ]; then
        local comp=$(get_component $index)
        echo -e "${BLUE}Installing $comp...${NC}"

        case "$comp" in
        "homebrew") setup_homebrew ;;
        "dependencies") install_dependencies ;;
        "fonts") setup_fonts ;;
        "zsh") setup_zsh ;;
        "kitty") setup_kitty ;;
        "wezterm") setup_wezterm ;;
        "ghostty") setup_ghostty ;;
        "neovim") setup_neovim ;;
        "tmux") setup_tmux ;;
        "tmuxinator") setup_tmuxinator ;;
        "raycast") setup_raycast ;;
        "amethyst") setup_amethyst ;;
        esac

        echo -e "${GREEN}✓ $comp installed successfully${NC}"
      fi
      index=$((index + 1))
    done

    echo -e "\n${BOLD}${GREEN}Installation completed successfully!${NC}"
    ;;
  [bB])
    main_loop
    ;;
  *)
    echo "Installation cancelled."
    exit 0
    ;;
  esac
}

# Installation functions (from your original script)
check_dotfiles() {
  echo "Checking if dotfiles directory exists..."
  if [ ! -d "${DOTFILES_DIR}" ]; then
    echo "Directory ${DOTFILES_DIR} does not exist."
    echo "Cloning dotfiles repository..."
    git clone git@github.com:janwvjaarsveld/dotfiles.git "${DOTFILES_DIR}"
  else
    echo "Directory ${DOTFILES_DIR} exists."
  fi
  mkdir -p ~/.config
}

setup_homebrew() {
  echo "Setting up Homebrew..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  UNAME_MACHINE="$(uname -m)"
  if [ "${UNAME_MACHINE}" = "arm64" ]; then
    HOMEBREW_PREFIX="/opt/homebrew"
    HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}"
  else
    HOMEBREW_PREFIX="/usr/local"
    HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
  fi

  {
    echo
    echo "eval \"\$(${HOMEBREW_REPOSITORY}/bin/brew shellenv)\""
  } >>~/.zprofile

  eval "$(${HOMEBREW_REPOSITORY}/bin/brew shellenv)"
}

install_dependencies() {
  echo "Installing dependencies..."
  brew install neovim python3 asdf yarn ripgrep pyenv the_silver_searcher fd lazydocker lazygit git wget curl unzip fontconfig go fzf imagemagick
}

setup_fonts() {
  echo "Setting up fonts..."
  brew tap homebrew/cask-fonts
  brew install font-meslo-for-powerline font-meslo-lg-nerd-font
  fc-cache -fv
}

setup_zsh() {
  echo "Setting up zsh..."
  brew install zsh
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  for FILE in $(ls -A ${DOTFILES_DIR}/zsh); do
    echo "Symlinking $HOME/dotfiles/zsh/$FILE to ~/$FILE"
    ln -sf $DOTFILES_DIR/zsh/"$FILE" $HOME/"$FILE"
  done

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  chsh -s $(which zsh)
}

setup_kitty() {
  echo "Setting up kitty..."
  brew install kitty
  ln -sf $DOTFILES_DIR/kitty $HOME/.config/
}

setup_wezterm() {
  echo "Setting up wezterm..."
  brew install --cask wezterm
  ln -sf $DOTFILES_DIR/wezterm/.wezterm.lua $HOME/.wezterm.lua
}

setup_ghostty() {
  echo "Setting up ghostty..."
  brew install --cask ghostty
  ln -sf $DOTFILES_DIR/ghostty $HOME/.config
}

setup_neovim() {
  echo "Setting up neovim..."
  ln -sf $DOTFILES_DIR/nvim $HOME/.config/
}

setup_tmux() {
  echo "Setting up tmux..."
  brew install tmux
  for FILE in $(ls -A ${DOTFILES_DIR}/tmux); do
    ln -sf $DOTFILES_DIR/tmux/"$FILE" $HOME/"$FILE"
  done
}

setup_tmuxinator() {
  echo "Setting up tmuxinator..."
  brew install tmuxinator
  ln -sf $DOTFILES_DIR/tmuxinator $HOME/.config/
}

setup_raycast() {
  echo "Setting up Raycast..."
  brew install --cask raycast
}

setup_amethyst() {
  echo "Setting up Amethyst..."
  brew install --cask amethyst
}

# Find first interactive menu item
find_first_interactive() {
  local index=0
  for item in $MENU_ITEMS; do
    if is_interactive "$item"; then
      CURSOR_POS=$index
      return
    fi
    index=$((index + 1))
  done
}

# Main interactive loop
main_loop() {
  init_display
  build_menu
  find_first_interactive

  while true; do
    draw_menu

    # Read a single character
    read -rsn1 key

    # Handle escape sequences (arrow keys)
    if [ "$key" = $'\033' ]; then
      read -rsn2 key
      # Extract the direction character
      key="${key#?}"
    fi

    handle_key "$key"
  done
}

# Main function
main() {
  # Check if we have a reasonable terminal
  if [ -z "$TERM" ]; then
    echo "Error: This script requires a terminal with ANSI support"
    exit 1
  fi

  # echo "Starting Development Environment Installer..."
  # echo "Press any key to continue..."
  # read -rsn1

  check_dotfiles
  main_loop
}

# Entry point
if [ "${0##*/}" = "$(basename "${BASH_SOURCE[0]}" 2>/dev/null || echo install.sh)" ]; then
  main "$@"
fi
