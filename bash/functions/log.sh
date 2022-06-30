#! /bin/bash

 ###########################################
## Global(s)/Constant(s)/Local Variable(s) ##
 ###########################################
## Constant(s) ##
# Includes constant(s) relevant to logger method.
source $BASH_FUNCTIONS_CONSTANTS/log.sh

 ###############
## Function(s) ##
 ###############
IFS='' read -r -d '' LOG_DOC <<"EOF"
#/ DESCRIPTION:
#/	Used to produce log messages. Current global log level, tracked by 'BASH_LOG_LEVEL',
#/	is used to determine if given message should be printed.
#/
#/ USAGE: log [OPTIONS]... -m="message text"...
#/
#/ NOTE(S):
#/	- Method may not use bash logger... hopfully it's obvious why.
#/
#/ OPTION(S):
#/	-h, --help
#/		Print this help message. Function will return code of '0'. No processing will be
#/		done.
#/		(OPTIONAL)
#/	-c=<functionName>
#/		Name of calling code (function).
#/			- Note: If not given, field won't be included in log message.
#/		(OPTIONAL)
#/	-m=<logMsg>, --msg=<logMsg>
#/		Message user would like log produced of.
#/			- Note: At least one of these is required. If multiple are given, each
#/				will show up on a new line.
#/		(REQUIRED)
#/	--line-title
#/		When given, resulting log text will include a prefix and postfix.
#/			- Note: Shouldn't be combined with any other title option.
#/			- Note: If no title option is given, then no prefix, postfis, header, or
#/				footer will be included in the resulting log text.
#/		(OPTIONAL)
#/	--full-title
#/		When given, resulting log text will include a prefix, postfix, header, and
#/		footer.
#/			- Note: Shouldn't be combined with any other title option.
#/			- Note: If no title option is given, then no prefix, postfis, header, or
#/				footer will be included in the resulting log text.
#/		(OPTIONAL)
#/	-t, --trace
#/		When given, the default *trace* formatting character will be used by prefix,
#/		postfix, header, and footer (if used). Providing this option will also cause a
#/		log message with the given text to be printed to stdout *if* the bash log level
#/		($BASH_LOG_LEVEL) is equal to, or higher than, *trace*. This includes: trace,
#/		debug, info, warn, and error.
#/			- Note: Shouldn't be combined with any other log level option.
#/			- Note: If multiple loge level options are given in a single call, the
#/				last one given will be used.
#/			- Note: When no log level option is provided, *trace* level is used.
#/		(DEFAULT)
#/	-d, --debug
#/		When given, the default *debug* formatting character will be used by prefix,
#/		postfix, header, and footer (if used). Providing this option will also cause a
#/		log message with the given text to be printed to stdout *if* the bash log level
#/		($BASH_LOG_LEVEL) is equal to, or higher than, *debug*. This includes: debug,
#/		info, warn, and error.
#/			- Note: Shouldn't be combined with any other log level option.
#/			- Note: If multiple loge level options are given in a single call, the
#/				last one given will be used.
#/			- Note: When no log level option is provided, *trace* level is used.
#/		(OPTIONAL)
#/	-i, --info
#/		When given, the default *info* formatting character will be used by prefix,
#/		postfix, header, and footer (if used). Providing this option will also cause a
#/		log message with the given text to be printed to stdout *if* the bash log level
#/		($BASH_LOG_LEVEL) is equal to, or higher than, *info*. This includes: info, warn,
#/		and error.
#/			- Note: Shouldn't be combined with any other log level option.
#/			- Note: If multiple loge level options are given in a single call, the
#/				last one given will be used.
#/			- Note: When no log level option is provided, *trace* level is used.
#/		(OPTIONAL)
#/	-w, --warn
#/		When given, the default *warn* formatting character will be used by prefix,
#/		postfix, header, and footer (if used). Providing this option will also cause a
#/		log message with the given text to be printed to stdout *if* the bash log level
#/		($BASH_LOG_LEVEL) is equal to, or higher than, *debug*. This includes: warn
#/		and error.
#/			- Note: Shouldn't be combined with any other log level option.
#/			- Note: If multiple loge level options are given in a single call, the
#/				last one given will be used.
#/			- Note: When no log level option is provided, *trace* level is used.
#/		(OPTIONAL)
#/	-e, --error
#/		When given, the default *error* formatting character will be used by prefix,
#/		postfix, header, and footer (if used). Providing this option will also cause a
#/		log message with the given text to be printed to stdout *if* the bash log level
#/		($BASH_LOG_LEVEL) is equal to, or higher than, *error*. This includes: error.
#/			- Note: Shouldn't be combined with any other log level option.
#/			- Note: If multiple loge level options are given in a single call, the
#/				last one given will be used.
#/			- Note: When no log level option is provided, *trace* level is used.
#/		(OPTIONAL)
#/
#/ RETURN CODE(S):
#/	- 0:
#/		Returned when:
#/			- Help message is requested OR
#/			- Processing is successfull.
#/	- 1:
#/		Returned when:
#/			- Required argument(s) haven't been provided.
#/	- 20:
#/		Returned when:
#/			- Provided option is invalid.
#/
#/ EXAMPLE(S):
#/	log --help
#/	log -c=${FUNCNAME[0]} -m="line1\nline2" -m="line3"
#/	log -d -c="$USER-terminal" -m="line1" -m="line2"
#/	log --error --line_title -m="line1" -m="line2"
#/
#/ TODO(S):
#/	- Flush out documentation of return code(s).
#/	- Check if I can use any sort of font formatting (ex. bold) in method description as printed by --help.
EOF
 ###############################
## Reset/Set Local Variable(s) ##
 ###############################
# Tracks given log level.
declare -i lvl=$TRACE
# Tracks name of given log level.
lvlNm="TRACE"
# Tracks name of calling function.
caller=""
# Tracks if log message should be treated as a title (and what type).
title=$NO_TITLE
# Used to build prefix to log message.
pfix="$(date +"%Y/%m/%d %H:%M:%S %Z")"
# Used to build final output message.
msg=""

 #####################
## Process Option(s) ##
 #####################
for fullArg in "${@}"; do
	# Tracks value of current option.
	declare arg=${fullArg#*=}

	# Determine what option user gave.
	case $fullArg in
		-c=*)
			caller=$arg  ;;
		-t|--trace)  ;;
		-d|--debug)
			lvl=$DEBUG
			lvlNm=DEBUG  ;;
		-i|--info)
			lvl=$INFO
			lvlNm=INFO  ;;
		-w|--warn)
			lvl=$WARN
			lvlNm="WARN "  ;;
		-e|--error)
			lvl=$ERROR
			lvlNm=ERROR  ;;
		-h|--help)
			echo "$LOG_DOC"
			exit 0  ;;
		-m=*|--msg=*)
			if [[ -z $msg ]]; then
				msg=$arg
			else
				msg+="\n$arg"
			fi  ;;
		--full-title)
			title=$FULL_TITLE  ;;
		--line-title)
			title=$LINE_TITLE  ;;
		*)
			printf "$pfix ERROR log:\t"
			$BASH_FUNCTIONS/output.sh --prefix --postfix -m="Calling function provided invalid option: '$fullArg', see doc:"
			echo "$LOG_DOC"
			exit 20  ;;
	esac
done

 ###########################
## Error Check Argument(s) ##
 ###########################
$BASH_FUNCTIONS/checkRequiredOpts.sh "$LOG_DOC" -a="${msg[@]}"
declare rtVal=$?
if [[ $rtVal -ne 0 ]]; then
	exit $rtVal
fi

# Determine if log message should be output.
if [[ $BASH_LOG_LEVEL -ge $lvl ]]; then
	# Build Log Prefix #
	if [[ $caller == "" ]]; then
		pfix+=" $lvlNm:"
	else
		pfix+=" $lvlNm $caller:"
	fi

	# Determine how log message should be built.
	if [[ $title -gt $NO_TITLE ]]; then
		## Build Call to Output ##
		output_call="$BASH_FUNCTIONS/output.sh -l=200"
		# Set level.
		if [[ $lvl -eq $TRACE ]]; then
			output_call+=" --trace"
		elif [[ $lvl -eq $DEBUG ]]; then
			output_call+=" --debug"
		elif [[ $lvl -eq $INFO ]]; then
			output_call+=" --info"
		elif [[ $lvl -eq $WARN ]]; then
			output_call+=" --warn"
		elif [[ $lvl -eq $ERROR ]]; then
			output_call+=" --error"
		fi
		# Set formatting option(s) and run output to get final text.
		if [[ $title -eq $FULL_TITLE ]]; then
			msg="$pfix\n$($output_call --indent=4 -p -m="$msg")\n"
		else
			msg="$pfix\n$($output_call --indent=8 --pre-post-fix -m="$msg")\n"
		fi
	else
		msg="$pfix\t$msg\n"
	fi

	# Output log.
	printf "$msg"
fi

