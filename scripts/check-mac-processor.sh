# Check if user's Mac is using an Intel or Apple Silicon processor

#!/bin/zsh

function check_mac_processor() {
    local ARCH_TYPE="$(uname -m)"

    if [ "${ARCH_TYPE}" = "x86_64" ]; then
    	if [ "$(sysctl -in sysctl.proc_translated)" -eq 1 ]; then
	    echo "Running on Rosetta 2"
    	else
	    echo "Running on Intel"
	fi
     elif [ "${ARCH_TYPE}" = "arm64" ]; then
	echo "Running on Apple Silicon"
     else
	echo "Unknown architecture: ${ARCH_TYPE}"
     fi
}

check_mac_processor

