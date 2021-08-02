#!/bin/bash

CONF_FILE="invoice.conf"

declare -a DAYS_WORKED



function add_workday(){
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
						DAYS_WORKED+=('thursday');
						return 0;
						;;
				friday)
						DAYS_WORKED+=('friday');
						return 0;
						;;
				saturday)
						DAYS_WORKED+=('saturday');
						return 0;
						;;
				sunday)
						DAYS_WORKED+=('sunday');
						return 0;
						;;
				*)
						return 1;
						;;
		esac
}

function check_hours(){
		# return tru if it matches regex for a single number or a ranger
		pattern='/((1[0-2]|0?[1-9]):([0-5][0-9]) ?([AaPp][Mm]))/';
		
		echo "checking $1";

		if [[ $1 =~ "-"  ]]; then # it is range
				echo "$1 is range";
				IFS='-';
				for i in "$1"; do  
						echo "$i"
				done
				IFS=' ';

		else 
				if [[ $1 =~ $pattern ]]; then 
					echo "$1 is hour";	
				else
						echo "$1 is not hour";
				fi
		fi
		

		
}

function is_weekday(){
		# return trut it it is a weekday
		case $1 in
				monday | thursday | wednesday | thursday | friday | saturday | sunday)
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

echo "checking parameters"

echo " total parameters passed:"
echo $#
echo ''

args=("$@"); # load parameter into array
		for ((i=0; i < $#; i++)); do
				arg=${args[$i]}
				if is_weekday $arg ; then 
						DAYS_WORKED+=($arg);
						i=$((i+1));
						hours=${args[$i]} # get next arg
						check_hours $hours;
				fi
				echo '';
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
