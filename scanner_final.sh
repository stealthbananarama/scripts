#!/bin/bash
# read in three arguments, store them in variables, and display them

# Make sure there are only 3 arguments
if [[ ${#@} != 3 ]]; then
	echo "Needs 3 arguments"
	exit
fi

ip=$1
start=$2
stop=$3

# set the IFS to a period
IFS='.'

#################################################################
##### VALIDATE IP ADDRESS
# 1) break apart the input
for arg in "$ip"; do
	# period is the delimiter
	parts=($arg)
done

# 2) Verify that it's exactly 3
if [[ !(${#parts[@]} -eq 3) ]]; then
	echo "Must be 3 octets long"
	exit
fi

# 3) Verify that each octet is numeric only
for arg in ${parts[@]}; do
	if [[ !($arg =~ ^[0-9]+$) ]]; then
		echo "Each octet must be numeric"
		exit
	fi
done
   
# 4) Verify that the first octet is at least 1, and 
# the second and third octets are at least 0, but less than 256
count=0
for arg in ${parts[@]}; do
	if [[ count -eq 0 ]]; then
		if [[ !($arg -ge 1 && $arg -le 255) ]]; then
			echo "First octet must be from 1 to 255"
			exit
		fi
		((count++))
		continue
	fi
	if [[ !($arg -ge 0 && $arg -le 255) ]]; then
		echo "Octet must be between 1 and 255"
		exit
	fi
done

# set the IFS back to a space
IFS=' '
#################################################################


#################################################################
##### VALIDATE RANGE VALUES
# make sure the end range is not less than the start range
if [[ $start -gt $stop ]]; then
	echo "Start of range must be less than or equal to end of range."
	exit
fi

# make sure both are greater than 0 and less than 255
if [[ $start -lt 0 || $start -gt 254 || $stop -lt 1 || $stop -gt 255 ]]; then
	echo "Start and stop must both be between 0 and 255"
	exit
fi	
#################################################################

# Input is now validated
# Now we want to take the validated input and use it to scan IP addresses

#################################################################
##### Scan for hosts

current=$start
while [[ $current -le $stop ]]; do
	output=$(ping -c 4 $ip.$current)
	if [[ $output == *"100% packet loss"* ]]; then
		echo "$ip.$current is not up"
	else
		echo "$ip.$current is up"
	fi 
	((current++))
done




