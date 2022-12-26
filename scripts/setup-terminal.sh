#!/bin/bash

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
    

}

main() {
   setup_environment
   install_iterm2
   install_powerlevel
   install_rust
}

main

