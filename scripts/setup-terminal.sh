#!/bin/bash

set -euo pipefail

setup_environment() {
   # Jump to root repository
   cd "$(git rev-parse --show-toplevel)"
   
   # Set permissions for *.sh
   find scripts -name '*.sh' -exec chmod +x {} +
}

import_dependent_source_files() {
   source "scripts/utils/colors.sh"
   source "scripts/utils/common.sh"
}

install_powerlevel() {
   echo "powerlevel10k"

   cd "$HOME" 
   git clone https://github.com/romkatv/powerlevel10k.git 
}

install_oh_my_zsh() {
   local oh_my_zsh_path="${HOME}/.oh-my-zsh"
   if ! command_exists "~/.oh-my-zsh";then
      echo "Installing Oh My Zsh..."
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   else
      echo "Oh My Zsh is already installed"
   fi
}

install_iterm2_brew_cask() {

}


check_iterm2_installed() {

}

install_brew_dependencies() {
   echo "Install iTerm2"
   brew cask install iterm2

   echo "Install neovim"
   brew install neovim

   echo "Install shellcheck"
   brew install shellcheck
}

install_rust() {
    echo "Installing rustup locally"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

setup_rust() {
   local cargo_path="export PATH=\"\$HOME/.cargo/bin:\$PATH\""
   local profile_file_location="${HOME}/.zprofile"
   if [[ $(grep "${cargo_path}" "${profile_file_location}" | wc -l) -eq 0 ]]; then
         echo "Setting cargo  path..."
	 printf "\n# Set PATH for cargo" >> "${profile_file_location}"
         printf "\n${cargo_path}" >> "${profile_file_location}"
   fi
}

install_tuist() {
    curl -Ls https://install.tuist.io | bash
    tuist
}

setup_rust_local() {
   install_rust
   setup_rust
   install_tuist
}

envinroment_local() {
   setup_environment
   import_dependent_source_files    
}

setup_terminal_local() {
   install_iterm2
   install_powerlevel
}

main() {
   envinroment_local
   install_oh_my_zsh
}

main

