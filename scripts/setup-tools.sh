#!/bin/bash
set -euo pipefail

# Jump to repository root
cd "$(git rev-parse --show-toplevel)"

# Give executable permission for all shell scripts
find scripts -name '*.sh' -exec chmod +x {} +

source "scripts/utils/colors.sh"

install_xcode_cli() {
   command -v xcode-select >/dev/null 2>&1 || xcode-select --install
}


function install_brew() {
   installBrew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
   command -v brew >/dev/null 2>&1 || eval $installBrew
}

function check_which_terminal() {
   local TERMINAL=$(echo $SHELL)

   if [[ $TERMINAL == *"zsh"* ]]; then
      PROFILE_FILE=".zprofile"
      echo -e "${CYAN_COLOR}You're using zsh as a shell ${END_COLOR}"
   elif [[ $TERMINAL == *"bash"* ]]; then
      PROFILE_FILE=".bash_profile"
      echo -e "${CYAN_COLOR}You're using bash as a shell ${END_COLOR}"
   fi
}

function check_if_profile_exists() {
   PROFILE_FILE_LOCATION="$HOME/$PROFILE_FILE"
   
   if [ -f "$PROFILE_FILE_LOCATION" ]; then
      echo -e "Profile file already exists at: $PROFILE_FILE"
   else
      echo "Profile file does not exist. Creating..."
      touch "$PROFILE_FILE_LOCATION"
   fi
}

function add_check_mac_processor_script_on_profile() {
   local find_name="$(cat "$PROFILE_FILE_LOCATION" | grep -Ic "check_mac_processor")"

   if [ "$find_name" -eq 0 ]; then
      echo "Adding check_mac_processor script to ${PROFILE_FILE}"
      cat scripts/check-mac-processor.sh >> $PROFILE_FILE_LOCATION
   fi 
}

function add_brew_path_location_to_processor() {
    local ARCH_TYPE="$(uname -m)"
 
    if [ ${ARCH_TYPE} = "arm64" ]; then
       check_export_brew_path_silicon_exists_profile	
    elif [ ${ARCH_TYPE} = "x86_64" ]; then
       check_export_brew_path_intel_exists_profile
    fi
}

function export_brew_path_silicon() {
   echo '# Set PATH, MANPATH, etc., for Homebrew.' >> "$PROFILE_FILE_LOCATION"
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$PROFILE_FILE_LOCATION"
   eval "$(/opt/homebrew/bin/brew shellenv)"
}

function check_export_brew_path_silicon_exists_profile() {
   local EVAL_HOMEBREW=$(eval "$(/opt/homebrew/bin/brew shellenv)")

   if [[ "$(grep "$EVAL_HOMEBREW" "$PROFILE_FILE_LOCATION" | wc -l) " -eq 0 ]]; then
      echo "${GREEN_COLOR}Setting Homebrew path... ${END_COLOR}"
      export_brew_path_silicon
   fi
   echo -e "${YELLOW_COLOR}Homebrew path is already added on PATH! ${END_COLOR}"
   eval "$(/opt/homebrew/bin/brew shellenv)"
}

function export_brew_path_intel() {
   echo '# Set PATH, MANPATH, etc., for Homebrew.' >> "$PROFILE_FILE_LOCATION"
   echo "export PATH=/usr/local/bin:$PATH" >> "$PROFILE_FILE_LOCATION"
}

function check_export_brew_path_intel_exists_profile() {
   local HOMEBREW_PATH_INTEL="export PATH=/usr/local/bin:$PATH"

   if [[ "$(grep "${HOMEBREW_PATH_INTEL}" "$PROFILE_FILE_LOCATION" | wc -l) " -eq 0 ]]; then
      echo -e "${GREEN_COLOR}Setting Homebrew path... ${END_COLOR}"
      export_brew_path_intel
   fi
   echo -e "${YELLOW_COLOR}Homebrew path is already added on PATH! ${END_COLOR}"
   eval ${HOMEBREW_PATH_INTEL}
}

function install_brew_deps() {
   brew update

   echo "Installing Saucery project dependencies..."

   brew install bash || (brew upgrade bash && brew cleanup bash)
   brew install xcodegen || (brew upgrade xcodegen && brew cleanup xcodegen)
   brew install swiftlint || (brew upgrade swiftlint && brew cleanup swiftlint)
   
   echo -e "${GREEN_COLOR}All dependencies successfully downloaded!${END_COLOR}"
}

function main() {
  install_xcode_cli
  install_brew
  check_which_terminal
  check_if_profile_exists 
  add_check_mac_processor_script_on_profile	  
  add_brew_path_location_to_processor
  install_brew_deps
}

main



