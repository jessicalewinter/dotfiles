#!/bin/bash

prepare_commit_msg_hook_setup() {
    if [ -z "$BRANCHES_TO_SKIP" ]; then
        BRANCHES_TO_SKIP=(master main develop dev)
    fi

    BRANCH_NAME=$(git symbolic-ref --short HEAD | grep -o '[A-Z]\+-[0-9]\+')
    BRANCH_NAME="${BRANCH_NAME##*/}"

    BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")
    BRANCH_IN_COMMIT=$(grep -c "\[$BRANCH_NAME\]" $1)

    if [ -n "$BRANCH_NAME" ] && ! [[ $BRANCH_EXCLUDED -eq 1 ]] && ! [[ $BRANCH_IN_COMMIT -ge 1 ]]; then 
        sed -i.bak -e "1s/^/$BRANCH_NAME: /" $1
    fi
}

prepare_commit_msg_hook_setup "$@"

