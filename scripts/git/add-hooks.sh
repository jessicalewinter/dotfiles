#!/bin/bash

set -euo pipefail

# Jump to repository root
cd "$(git rev-parse --show-toplevel)"

# Import colors file
source "scripts/utils/colors.sh"

add_prepare_commit_msg_hook() {
   if [ ! -f ".git/hooks/prepare-commit-msg" ];then
      mv .git/hooks/prepare-commit-msg.sample .git/hooks/prepare-commit-msg 
   fi
   
   echo "Setting hook permissions..."
   chmod u+x .git/hooks/prepare-commit-msg

   echo -e "${YELLOW_COLOR}Adding script to prepare-commit-msg hook...${END_COLOR}"
   cp scripts/git/hooks/prepare-commit-msg-hook.sh .git/hooks/prepare-commit-msg
   echo -e "${GREEN_COLOR}prepare-commit-msg hook installed successfully!${END_COLOR}"
}

main() {
   add_prepare_commit_msg_hook
}

main
