#!/bin/bash

CONF_FILE="invoice.conf"

declare -a DAYS_WORKED
declare -a STARTING_TIMES 
declare -a ENDING_TIMES 

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

function print_help(){
		echo """
			Something went wrong:
			plesae enter parameter of the form 12pm-2am
		"""
}


function is_time_regex(){
		# return tru if it matches regex for a single number or a ranger
		pattern='^([0-2])?[1-9](:[0-5][0-9])?([AaPp][mM])?$';
		if [[ $1 =~ $pattern ]]; then 
				return 0;
		else
				return 1;
		fi
}

function load_hours_param(){
		# return tru if it matches regex for a single number or a ranger
		echo "checking $1";
		if [[ $1 =~ "-"  ]]; then # it is range
				# divide range
				first=$(echo $1 | cut -d '-' -f 1); 
				if ! is_time_regex $first; then 
						echo "could not understand $first ";
						print_help;
						exit 1;
				else
						STARTING_TIMES+=("$first");
				fi			
				last=$(echo $1 | cut -d '-' -f 2);
				if ! is_time_regex $last; then 
						echo "could not understand $last ";
						print_help;
						exit 1;
				else 
						ENDING_TIMES+=("$last");
				fi			
		else 
				if ! is_time_regex $1; then 
						echo "could not understand $1 ";
						print_help;
						exit 1;
				else
						STARTING_TIMES+=("$STARTING_TIME");
						ENDING_TIMES+=("$1");
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

function load_config_file() {
		# load config file
		if test -f $CONF_FILE; then
				echo "Loding config file";
				source $CONF_FILE;
		else
				echo "Could not find $CONF_FILE";
				exit 
		fi
}

function load_parameter(){
		# load parameters 
		args=("$@"); # load parameter into array
				for ((i=0; i < $#; i++)); do # for every parameter
						arg=${args[$i]}
						if is_weekday $arg ; then 
								DAYS_WORKED+=("$arg"); # load weekday 
								i=$((i+1));
								hours=${args[$i]} # get next arg
								load_hours_param $hours;
						fi
				done
				return 0;
		}

function get_time_diff(){
		# return the difference in time between to given times
		first_time=$(date -d "$1" '+%s');
		latter_time=$(date -d "$2" '+%s')
		echo $first_time;
		echo $latter_time;

		echo $(date -u -d @$(($latter_time - $first_time)) '+%H:%M');
}

# load config file
load_config_file;

# check and load parameters
load_parameter $@;


#echo ${DAYS_WORKED[*]}
#echo ${STARTING_TIMES[*]}
#echo ${ENDING_TIMES[*]}

# Get the subject for the email
EMAIL_SUBJECT="${NAME}_Host_Invoice_$(date --date="today" +"%m-%d-%y")";



# for every day worked 
for ((i=0; i < ${#DAYS_WORKED[@]}; i++)); do # for every parameter

		# get the date of the last day worked 
		WORK_DATE=$(date --date="last ${DAYS_WORKED[$i]}" +"%B %d, %Y");
		WORK_DATE_NUMERIC=$(date --date="last ${DAYS_WORKED[$i]}" +"%m-%d-%y");
		echo "getting Date for last ${DAYS_WORKED[$i]}: $WORK_DATE";

		
		TIME_WORKED=$(get_time_diff ${STARTING_TIMES[$i]} ${ENDING_TIMES[$i]});
		#echo $TIME_WORKED;
		#LEAVE_TIME=$(date -d "${STARTING_TIMES[$i]} 5 hours" +'%H:%M %P')
		#echo "Leave time from ${STARTING_TIMES[$i]}: $LEAVE_TIME";

		echo ""
done



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
