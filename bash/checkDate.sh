#!/usr/bin/bash

date=$1
#format="DD-MM-YYYY"

# Plain string regex
#regexDate="^[0-9]{2}-[0-9]{2}-[0-9]{4}$";

# Grouping values
regexDate="([0-9]{2})-([0-9]{2})-([0-9]{4})";

if [[ $date =~ $regexDate ]]; then
        echo "Date is valid."
        day=${BASH_REMATCH[1]}
        month=${BASH_REMATCH[2]}
        year=${BASH_REMATCH[3]}
        echo "Date entered is:"
        echo "Day: $day, Month: $month, Year: $year"
else
        echo "Date entered is NOT valid."
fi
