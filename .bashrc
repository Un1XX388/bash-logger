# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f $HOME/bash/bash_aliases ]; then
	. $HOME/bash/bash_aliases
fi
if [ -f $HOME/bash/bash_functions ]; then
 	source $HOME/bash/bash_functions
fi

 #####################
## Environment Setup ##
 #####################
## History Setting(s) ##
# Total number of entries in history file.
HISTSIZE=5000
# Adds time info to the command history.
export HISTTIMEFORMAT='%F %T '
# Removes duplicate sequential entries from command history.
export HISTCONTROL=$HISTCONTROL:ignoredups
# Ignores commands that start with ' '.
export HISTCONTROL=$HISTCONTROL:ignorespace
# Moves location of history file.
export HISTFILE=$HOME/bash/bash_history

## Terminal Setup ##
# When tab-completing, match regardless of case.
bind "set completion-ignore-case on"
# When tab-completing, only requires one press of tab instead of 2 (default).
bind "set show-all-if-ambiguous on"
# The above two options make hidden files show up by default, this turns that behaviour off.
#bind "set match-hidden-files off"
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

unset rc

