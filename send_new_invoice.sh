#!/bin/bash

#Defining vaiables

GMAIL_FROM="gorantopic.bot@gmail.com";
GMAIL_PASSWORD="rs8G9sgx5PNBhX5";

EMAIL_TO="daniel@thepearlgroup.us";

EMAIL_MESSAGE_FILE="../email_message.txt"

NAME="Goran_Topic"; # name to be used 

STARTING_TIME="8:00 pm";

DAY_OF_WORK="saturday";

HOUR_RATE=15; # fifteen dollaras an hour
# get the date of the lst saturday
WORK_DATE=$(date --date="last $DAY_OF_WORK" +"%B %d, %Y");
WORK_DATE_NUMERIC=$(date --date="last $DAY_OF_WORK" +"%m-%d-%y");
echo "getting Date for last $DAY_OF_WORK: $WORK_DATE";

# Get the subject for the email
SUBJECT="${NAME}_Host_Invoice_${WORK_DATE_NUMERIC}";

if [ $# -gt 0 ]
	then 
			NUMBER_OF_HOURS_WORKED=$1
			LEAVE_TIME=$(date -d "$STARTING_TIME $NUMBER_OF_HOURS_WORKED hours" +'%H:%M %P')
	else 
			echo "Setting number of hours worked to 5";
			NUMBER_OF_HOURS_WORKED=5
			LEAVE_TIME=$(date -d "$STARTING_TIME $NUMBER_OF_HOURS_WORKED hours" +'%H:%M %P')
			
fi

MATCH_STRING="\\\hourrow{.*"
REPLACING_STRING="\\\hourrow{Hosting services from $STARTING_TIME to $LEAVE_TIME}{$NUMBER_OF_HOURS_WORKED}{$HOUR_RATE}"

echo "Getting latex files..."
cd latex_files
echo "Makeing Tex file"
# replace the date with the date of the day of work
sed "s/\\\today/$WORK_DATE/" template.tex  > buffer1.tex
# replace the detail string with current information
sed "s/$MATCH_STRING/$REPLACING_STRING/" buffer1.tex > edited_template.tex
\rm -f buffer1.tex

echo "compiling Latex..."
pdflatex edited_template.tex

cp edited_template.pdf ../archive/$SUBJECT.pdf

echo "sending mail to $EMAIL_TO"
# mailx to send the invoice
mailx -v  -s "$SUBJECT" \
		-S smtp-use-starttls \
		-S ssl-verify=ignore \
		-S smtp-auth=login \
		-S smtp=smtp://smtp.gmail.com:587 \
		-S from="$NAME" \
		-S smtp-auth-user="$GMAIL_FROM" \
		-S smtp-auth-password="$GMAIL_PASSWORD" \
		-S ssl-verify=ignore \
		-a "../archive/$SUBJECT.pdf" \
		"$EMAIL_TO" < $EMAIL_MESSAGE_FILE


echo "email send succesfully!"
