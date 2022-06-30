#! /bin/bash

 ###################
## Text Formatting ##
 ###################
# Default line length including formatting (ex. prefix & postfix).
declare -ir DEFAULT_LINE_LENGTH=100
# Default number of spaces message text should be indented by.
declare -ir DEFAULT_INDENT=0

 #################################
## Message Severity Character(s) ##
 #################################
# Default formatting character.
declare -r DEFAULT_CHAR='#'
# Trace formatting character.
declare -r TRACE_CHAR='.'
# Info formatting character.
declare -r INFO_CHAR=$DEFAULT_CHAR
# Debug formatting character.
declare -r DEBUG_CHAR='+'
# Warning formatting character.
declare -r WARN_CHAR='*'
# Error formatting character.
declare -r ERROR_CHAR='!'

