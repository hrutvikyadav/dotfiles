#!/bin/bash

# Read the start and end date of the week from the user
#read -p "Enter the start date of the week (dd-mm-yyyy): " start_date
#read -p "Enter the end date of the week (dd-mm-yyyy): " end_date
#
## Convert the start and end dates to epoch time
#start_epoch=$(date -d $(echo $start_date | awk -F "-" '{print $3 "-" $2 "-" $1}') +%s)
#end_epoch=$(date -d $(echo $end_date | awk -F "-" '{print $3 "-" $2 "-" $1}') +%s)
#
## Generate the regex
#regex="^("
#for (( i=$start_epoch; i<=$end_epoch; i+=86400 ))
#do
  #regex+="$(date -d "@$i" +%d-%m-%Y)|"
#done
#regex="${regex::-1})$"
#
#echo "Regex to match any date between $start_date and $end_date:"
#echo $regex

#!/bin/bash

# Calculate the start and end date of the current week
start_date=$(date -d "last Monday" +%d-%m-%Y)
end_date=$(date -d "next Saturday" +%d-%m-%Y)

# Convert the start and end dates to epoch time
start_epoch=$(date -d $(echo $start_date | awk -F "-" '{print $3 "-" $2 "-" $1}') +%s)
end_epoch=$(date -d $(echo $end_date | awk -F "-" '{print $3 "-" $2 "-" $1}') +%s)

# Generate the regex
regex="^("
for (( i=$start_epoch; i<=$end_epoch; i+=86400 ))
do
  regex+="$(date -d "@$i" +%d-%m-%Y)|"
done
regex="${regex::-1})"

#echo "Regex to match any date between $start_date and $end_date:"
echo -n $regex

