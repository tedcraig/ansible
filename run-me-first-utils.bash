#!/usr/bin/env bash

# ===================================================================
#
#   Name:   run-me-first-utils.bash
#   desc:   Installs core utils needed immediately 
#           after fresh macOS install. 
#
#   NOTE:   
#           
#   
#
# ===================================================================


# -----------------------------------------------------------------------------
# Generates RGB color escape code string using the argument values supplied. 
# Arguments:
#   position 1:  Red    value (0-255)
#   position 2:  Blue   value (0-255)
#   position 3:  Green  value (0-255)
# -----------------------------------------------------------------------------
get_rgb_escape_code() {  
  local RED=$1
  local GREEN=$2
  local BLUE=$3
  echo '\033[38;2;'"${RED};${GREEN};${BLUE}"'m'
}


# -----------------------------------------------------------------------------
# Sets active color to terminal default.
# Globals:
#   none
# Arguments:
#   none
# -----------------------------------------------------------------------------
reset_color() {
  printf "\033[0m"
}

# -----------------------------------------------------------------------------
# Sets color to specified RGB value.
# This color will remain active until the it is intentionally reset.
# Globals:
#   none
# Arguments:
#   position 1:  Red    value (0-255)
#   position 2:  Blue   value (0-255)
#   position 3:  Green  value (0-255)
# -----------------------------------------------------------------------------
set_color_rgb() {
  local RED=$1
  local GREEN=$2
  local BLUE=$3
  printf "\033[38;2;%d;%d;%dm" ${RED} ${GREEN} ${BLUE};
}


# =============================================================================
#   MAIN
# =============================================================================
main() {

COLOR_BLUE=$(get_rgb_escape_code 0 125 255)
COLOR_GOLD=$(get_rgb_escape_code 255 200 50)
COLOR_GREEN=$(get_rgb_escape_code 50 255 50)
COLOR_RESET="\033[0m"

# install homebrew package manager
echo -e "${COLOR_BLUE}==>${COLOR_GOLD} install homebrew (includes install of Xcode Command Line Tools):${COLOR_RESET}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install ansible cloud automation tool
echo -e "${COLOR_BLUE}==>${COLOR_GOLD} install ansible:${COLOR_RESET}"
brew install ansible

# install git
echo -e "${COLOR_BLUE}==>${COLOR_GOLD} install git:${COLOR_RESET}"
brew install git

# configure git
echo -e "${COLOR_BLUE}==>${COLOR_GOLD} configure git:${COLOR_RESET}"
git config --global user.name "tedcraig"
git config --global user.email tb3034me@gmail.com

# create scripts directory in home
echo -e "${COLOR_BLUE}==>${COLOR_GOLD} create scripts directory in home:${COLOR_RESET}"
mkdir ~/scripts || {
  echo 'unable to make directory ~/scripts'
  exit
}

# clone anisble repo from github
echo -e "${COLOR_BLUE}==>${COLOR_GOLD} clone ansible repo from github into ~/scripts:${COLOR_RESET}"
cd ~/scripts || {
  echo 'unable to change directory into ~/scripts'
  exit
}
git clone https://github.com/tedcraig/ansible.git

echo -e "${COLOR_BLUE}==>${COLOR_GREEN} complete!  ${COLOR_GOLD}Run an ansible playbook for further installations${COLOR_RESET}"

reset_color
}


# invoke main
main "$@"