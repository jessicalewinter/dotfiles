#!/bin/bash

setup_environment() {
   # Set permissions for *.sh
   find Scripts -name '*.sh' -exec chmod +x {} +
}

install_iterm2() {
   local termFile=iTerm2-3_4_18.zip
   curl -O https://iterm2.com/downloads/stable/iTerm2-3_4_18.zip
   open ${termFile}
   rm ${termFile}	
}

install_powershell() {
   echo "hello"
}

main() {
   setup_environment
   install_iterm2
}

main

