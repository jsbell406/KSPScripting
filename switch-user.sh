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
<<<<<<< HEAD
        if [[-f ~/.james_config ]]
		then
=======
        if [[-f ~/.james_config ]] ; then
>>>>>>> 9ff61fc1b6b1395693492cc72f35c82ab9cd071a
            yes | cp -rf ~/.james_config ~/.gitconfig
            source ~/.gitconfig
        fi
    ;;
<<<<<<< HEAD
    josh)
        if [[-f ~/.josh_config ]]
		then
            yes | cp -rf ~/.josh_config ~/.gitconfig
=======
    buddy)
        if [[-f ~/.buddy_config ]] ; then
            yes | cp -rf ~/.buddy_config ~/.gitconfig
>>>>>>> 9ff61fc1b6b1395693492cc72f35c82ab9cd071a
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