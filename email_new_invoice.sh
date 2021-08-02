#!/bin/bash

CONF_FILE="invoice.conf"

declare -a DAYS_WORKED



function check_day_of_week(){
		echo $1;
		case $1 in
				monday)
						echo -n "got monday";
						DAYS_WORKED+=('monday');
						return 0;
						;;
				tuesday)
						echo -n "got tuesday";
						DAYS_WORKED+=('tuesday');
						return 0;
						;;
				wednesday)
						echo -n "got wednesday";
						DAYS_WORKED+=('wednesday');
						return 0;
						;;
				thursday)
						echo -n "got thursday";
						DAYS_WORKED+=('thursday');
						return 0;
						;;
				friday)
						echo -n "got friday";
						DAYS_WORKED+=('friday');
						return 0;
						;;
				saturday)
						echo -n "got saturday";
						DAYS_WORKED+=('saturday');
						return 0;
						;;
				sunday)
						echo -n "got sunday";
						DAYS_WORKED+=('sunday');
						return 0;
						;;
				*)
						return 1;
						;;
		esac
}


function check_config_file() {
		# load config file
		if test -f $CONF_FILE; then
				echo "Loding config file";
				source $CONF_FILE;
		else
				echo "Could not find $CONF_FILE";
				exit 
		fi
}

echo "chekcing parameters"

echo $#

args=("$@"); # load parameter into array
		for ((i=0; i < $#; i++)); do
				#echo ${args[$i]};
				if check_day_of_week ${args[$i]}; then 
						echo "is weekday" ;
						i+=1;
						echo $i;
				else
						echo "is not weekday";
				fi
		done

#check_config_file
#echo $NAME


# get the date of the last day worked 
#WORK_DATE=$(date --date="last $DAY_OF_WORK" +"%B %d, %Y");
#WORK_DATE_NUMERIC=$(date --date="last $DAY_OF_WORK" +"%m-%d-%y");
#echo "getting Date for last $DAY_OF_WORK: $WORK_DATE";

# Get the subject for the email
#SUBJECT="${NAME}_Host_Invoice_${WORK_DATE_NUMERIC}";

#if [ $# -gt 0 ]
	#then 
			#NUMBER_OF_HOURS_WORKED=$1
			#LEAVE_TIME=$(date -d "$STARTING_TIME $NUMBER_OF_HOURS_WORKED hours" +'%H:%M %P')
	#else 
			#echo "Setting number of hours worked to 5";
			#NUMBER_OF_HOURS_WORKED=5
			#LEAVE_TIME=$(date -d "$STARTING_TIME $NUMBER_OF_HOURS_WORKED hours" +'%H:%M %P')
			
#fi

#MATCH_STRING="\\\hourrow{.*"
#REPLACING_STRING="\\\hourrow{Hosting services from $STARTING_TIME to $LEAVE_TIME}{$NUMBER_OF_HOURS_WORKED}{$HOUR_RATE}"

#echo "Getting latex files..."
#cd latex_files
#echo "Makeing Tex file"
# replace the date with the date of the day of work
#sed "s/\\\today/$WORK_DATE/" template.tex  > buffer1.tex
# replace the detail string with current information
#sed "s/$MATCH_STRING/$REPLACING_STRING/" buffer1.tex > edited_template.tex
#\rm -f buffer1.tex

#echo "compiling Latex..."
#pdflatex edited_template.tex

#cp edited_template.pdf ../archive/$SUBJECT.pdf

#echo "sending mail to $EMAIL_TO"
# mailx to send the invoice
# mailx -v  -s "$SUBJECT" \
#		-S smtp-use-starttls \
#		-S ssl-verify=ignore \
#		-S smtp-auth=login \
#		-S smtp=smtp://smtp.gmail.com:587 \
#		-S from="$NAME" \
#		-S smtp-auth-user="$GMAIL_FROM" \
#		-S smtp-auth-password="$GMAIL_PASSWORD" \
#		-S ssl-verify=ignore \
#		-a "../archive/$SUBJECT.pdf" \
#		"$EMAIL_TO" < $EMAIL_MESSAGE_FILE


#echo "email send succesfully!"
