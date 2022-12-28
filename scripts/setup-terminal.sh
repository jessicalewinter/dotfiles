#!/bin/bash

set -euo pipefail

setup_environment() {
   # Set permissions for *.sh
   find Scripts -name '*.sh' -exec chmod +x {} +

   # Jump to root repository
   cd "$(git rev-parse --show-toplevel)"
}

install_iterm2() {
   local temp_file=iTerm2-3_4_18.zip
   local app_file=iTerm.app
   curl -O https://iterm2.com/downloads/stable/iTerm2-3_4_18.zip
   
   tar -xvf "${temp_file}"

   open "${app_file}"

   rm "${temp_file}"
   rm "${app_file}"	
}

install_powerlevel() {
   echo "powerlevel10k"

   cd "$HOME" 
   git clone https://github.com/romkatv/powerlevel10k.git 
}

install_neovim() {
   brew install newovim
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

main() {
   setup_environment
   install_iterm2
   install_powerlevel
   install_rust
   setup_rust
}

main

