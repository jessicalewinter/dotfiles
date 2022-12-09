# Configure Rosetta
#!/bin/zsh

arch_name="$(uname -m)"

if [ "${arch_name}" = "x86_64" ]; then
    if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
        echo "Running on Rosetta 2"
    else
        echo "Running on native Intel"
    fi
elif [ "${arch_name}" = "arm64" ]; then
    echo "Running on Apple Silicon"
    export PATH="/opt/homebrew/bin:$PATH"
else
    echo "Unknown architecture: ${arch_name}"
fi


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

## plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /Users/jessica.lewinter/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### rbenv
##################################################

# Initialize rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";

  export PATH="$HOME/.rbenv/shims:$PATH"
fi

# Source rbenv completions
if [[ -s "~/.rbenv/completions/rbenv.zsh" ]]; then
  source "~/.rbenv/completions/rbenv.zsh"
fi
export PATH="$PATH:$HOME/bin"

export PYTHONPATH="${PYTHONPATH}:$HOME/Library/Python/3.9/lib/python3.9/site-packages/"

# Netskope alias
alias netskope-off="sudo launchctl unload /Library/LaunchDaemons/com.netskope.client.auxsvc.plist && sudo chmod -x /Applications/Netskope\ Client.app/ && sudo killall Netskope\ Client"
alias netskope-on="sudo launchctl load /Library/LaunchDaemons/com.netskope.client.auxsvc.plist && sudo chmod +x /Applications/Netskope\ Client.app/ && open -a /Applications/Netskope\ Client.app"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
alias xgen="make generate; echo; echo xgen command is deprecated, use \'make generate\'"

bindkey \^U backward-kill-line

