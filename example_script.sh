#! /bin/bash

infoLvl="-i -c=example_script"

log $infoLvl -m="Requesting input from user..."
printf "Enter number you'd like to count to: "
read userVar
log $infoLvl -m="User entered: '$userVar'"

for (( i=1; i<=$userVar; i++)); do
	echo "$i"
done

