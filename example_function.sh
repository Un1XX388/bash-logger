#! /bin/bash

 ###############
## Function(s) ##
 ###############
IFS='' read -r -d '' FUNCTION_NAME_DOC <<"EOF"
#/ DESCRIPTION:
#/	TODO
#/
#/ USAGE: functionName [OPTIONS]... [ARGUMENTS]...
#/
#/ NOTE(S):
#/	- None.
#/
#/ OPTION(S):
#/	-h, --help
#/		Print this help message. Function will return code of '0'. No processing will be
#/		done.
#/		(OPTIONAL)
#/ 
#/ RETURN CODE(S):
#/	- 0:
#/		Returned when:
#/			- Help message is requested OR
#/			- Processing is successful.
#/	- 20:
#/		Returned when:
#/			- Given option is invalid.
#/
#/ EXAMPLE(S):
#/	functionName --help
#/
#/ TODO(S):
#/	- TODO
EOF
function example {
	echo "HERE"
	log -i -c=${FUNCNAME[0]} --full-title -m="Title Text Here (${FUNCNAME[0]})"

	log -c=${FUNCNAME[0]} -m="Resetting local variable(s)..."
	 ###############################
	## Reset/Set Local Variable(s) ##
	 ###############################
	# Logging var(s).
	declare traceLvl="-c=${FUNCNAME[0]}"
	declare debugLvl="-d -c=${FUNCNAME[0]}"
	declare infoLvl="-i -c=${FUNCNAME[0]}"
	declare warnLvl="-w -c=${FUNCNAME[0]}"
	declare errorLvl="-e -c=${FUNCNAME[0]}"
	log $traceLvl -m="Local variable(s) reset."

	 #####################
	## Process Option(s) ##
	 #####################
	for fullArg in "${@}"; do
		log $traceLvl -m="Processing option: '$fullArg'..."
		# Tracks value of current option.
		declare arg=${fullArg#*=}

		# Determine what option user gave.
		case $fullArg in
			-h|--help)
				echo "$OUTPUT_DOC"
				exit 0  ;;
			*)
				log $errorLvl --full-title -m="Invalid given argument: '$fullArg', see doc:"
				echo "$FUNCTION_NAME_DOC"
				return 20  ;;
		esac
	done

	 ###########################
	## Error Check Argument(s) ##
	 ###########################
	log $traceLvl -m="Ensuring all required argument(s) were given..."
#	checkRequiredOpts "$THIS_FUNCTIONS_DOC" "-a=$varHoldingValOfRequiredArg"
#	declare rtVal=$?
#	if [[ $rtVal -ne 0 ]]; then
#		return $rtVal
#	fi
	log $debugLvl -m="All required argument(s) were given."
}

case "$1" in
    "")
    	;;
    example)
    	"$@"
    	exit  ;;
    *)
    	log_error "Unkown function: $1()"
    	exit 2  ;;
esac
