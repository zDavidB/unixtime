#!/usr/bin/env bash

# Bash Script    unixtime.sh
# Author         David Bell (zDavidB)
#
# Changelog:
#    MODIFIED    VERSION    (DD/MM/YYYY)
#    zDavidB     1.0.0      30/11/2018 - Created
#
# Run tests using BATS and the test script unixtime.bats
# See README.md for details.
# Has only been tested and intended to work on Mac OS.
#
# Script is intended to be set as an alias function.

#set -u

function print_usage {
    local exit_code=0

    cat <<-USAGE
		unixtime.sh \$1 \$2

        Takes zero, or one or two  inputs to return the date and time, with the equivalent Unix time.
        \$1 = the date field, either blank for current date, a specific date yyyy-mm-dd or a +/- offset in days
        \$2 = the time field, either blank for the current time, a specific time HH:mi:ss or +/- offset in hours

        Usage: unixtime.sh : uses current date and time
        unixtime.sh -n     : uses the date n days ago and current time
        unixtime.sh -0 -n  : uses the current date and time n hours ago
        unixtime.sh 2019-01-21 06:30:00  : uses the specific date and time
        - or combinations of specific date/time and +/- offset


		Output 
		    21/01/2019 06:30:00 1548052200

		Other Options

		    -h    Prints this message and exits
	USAGE

    return "$exit_code"
}

#######################################################################
# Main process
#######################################################################

if [ -z "${1}" ]; then
    input_date=$(date "+%F")
elif [ "${1}" == "-h" ]; then
    print_usage
    exit "$?"
else
    input_date=$1
fi

if [ -z "${2}" ]; then
    input_time=$(date "+%T")
else
    input_time=$2
fi

if [[ $1 =~ ^([+-][0-9]+)$ ]]; then

    input_date=$(date -v"${1}"d "+%F")

fi

if [[ $2 =~ ^([+-][0-9]+)$ ]]; then

    input_time=$(date -v"${2}"M "+%T")

fi

unixtime=$(date -j -f "%F %T" "${input_date} ${input_time}" +%s)
realtime=$(date -j -f "%s" "${unixtime}" "+%d-%m-%Y %T")

echo "${realtime} ${unixtime}"