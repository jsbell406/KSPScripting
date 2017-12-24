#!/usr/bin/env bash

# Scritp for James to switch ,gitconfig users
# TODO - Needs testing

set -e

# local variables
OPTION=$1

clear
echo "Switching users to [$1]"  
case $OPTION in
    james)
        if [[-f ~/.james_config ]]
            cp -u ~/.james_config ~/.gitconfig
            source ~/.gitconfig
        fi
    ;;
    buddy)
        if [[-f ~/.buddy_config ]]
            cp -u ~/.buddy_config ~/.gitconfig
            source ~/.gitconfig
        fi
    ;;
    *)
        echo "Unknown User [$1]"
        echo "Nothing To Do, Bye!!"
    ;;
esac

exit 0