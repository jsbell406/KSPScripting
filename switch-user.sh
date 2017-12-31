#!/usr/bin/env bash

################################################################################
# Script for James to switch ,gitconfig users
#
# Usage.....: switch-user.sh username
# Example...: switch-user.sh james
#
# Note: ~/ is the uers home directory. On Windows = C:\Users\<user-name>
# 
#      ~/ must contain the configuration file that you want
#      to swtich "to", in this case: ~/.james_config
#
################################################################################

# TODO - James - Needs full testing

# exit on any error
set -e

# load first parameter form user
OPTION=$1

clear
echo "Switching users to [$1]"  

# start optional switch
case $OPTION in
    james)
        if [[-f ~/.james_config ]] ; then
            yes | cp -rf ~/.james_config ~/.gitconfig
            source ~/.gitconfig
        fi
    ;;
<<<<<<< HEAD
    buddy)
        if [[-f ~/.buddy_config ]] ; then
            yes | cp -rf ~/.buddy_config ~/.gitconfig
=======
    josh)
        if [[-f ~/.josh_config ]] ; then
            yes | cp -rf ~/.josh_config ~/.gitconfig
>>>>>>> 68970830f0cdcb38ed479acdabeb28f39235eaa6
            source ~/.gitconfig
        fi
    ;;
    *)
        # if $1 us unknown, display a how-to message
        echo "Unknown User [$1]"
        echo "Usage: $0 [username ]"
        echo ""
        echo "Make sure ~/.$1_config profile exists"
        echo ""
    ;;
esac

exit 0
