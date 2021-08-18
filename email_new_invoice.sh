#!/bin/bash

CONF_FILE="invoice.conf";
LATEX_FILE="invoice.tex";
EMAIL_MESSAGE_FILE="email_message.txt";

declare -a DAYS_WORKED;
declare -a STARTING_TIMES;
declare -a ENDING_TIMES;

function print_help(){
		echo """
			Something went wrong:
			plesae enter parameter of the form: 
				email_new_invoice staurday 12pm-2am friday 12pm sunday 25:00

		"""
}

function is_time_regex(){
		# return true if it matches regex for a single number or a ranger
		pattern='^([0-2])?[1-9]?[0-9](:[0-5][0-9])?([AaPp][mM])?$';
		if [[ $1 =~ $pattern ]]; then 
				return 0;
		else
				return 1;
		fi
}

function load_hours_param(){
		# return true if it matches regex for a single number or a ranger
		echo "checking $1";
		if [[ $1 =~ "-"  ]]; then # it is range
				# divide range
				first=$(echo $1 | cut -d '-' -f 1); 
				if ! is_time_regex $first; then 
						echo "could not understand $first ";
						print_help;
						exit 1;
				else
						STARTING_TIMES+=($(date -d"$first" '+%l:%M%P'));
				fi			
				last=$(echo $1 | cut -d '-' -f 2);
				if ! is_time_regex $last; then 
						echo "could not understand $last ";
						print_help;
						exit 1;
				else 
						ENDING_TIMES+=($(date -d"$last" '+%l:%M%P'));
				fi			
		else 
				if ! is_time_regex $1; then 
						echo "could not understand $1 ";
						print_help;
						exit 1;
				else
						STARTING_TIMES+=($(date -d"$STARTING_TIME" '+%l:%M%P'));
						ENDING_TIMES+=($(date -d"$1" '+%l:%M%P'));
				fi
		fi
}

function is_weekday(){
		# return true it it is a weekday
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
		later_time=$(date -d "$2" '+%s');
		hours=$(date -u -d @$(($later_time - $first_time)) '+%H');
		minutes=$(date -u -d @$(($later_time - $first_time)) '+%M');
		echo "$hours.$((($minutes*10)/6))"
}

function write_invoice_header(){
		# writes to a latex file using the detail from the config file
		# Use the custom invoice class (invoice.cls)
		echo '\documentclass{invoice}' > $LATEX_FILE
		# Define \tab to create some horizontal white space
		echo '\def \tab {\hspace*{3ex}}' >> $LATEX_FILE 
		# begin document 
		echo '\begin{document}' >> $LATEX_FILE
		#--------------------
		# HEADING SECTION
		#--------------------
		# Company providing the invoice

		echo "\hfil{\Huge\bf $NAME}\hfil" >> $LATEX_FILE
		# Whitespace
		echo '\bigskip\break' >> $LATEX_FILE
		# Horizontal line
		echo '\hrule' >> $LATEX_FILE 
		# Your address and contact information
		echo "$ADDRESS \hfill  \\\ " >> $LATEX_FILE
		echo "$CITY, $STATE $ZIP_CODE \hfill $PERSONAL_EMAIL" >> $LATEX_FILE
		echo '\\ \\' >> $LATEX_FILE
		echo '{\bf Invoice To:} \\' >> $LATEX_FILE
		# Invoice recipient
		echo "\tab $RECIP_NAME \\\ " >> $LATEX_FILE
		# Recipient's company
		echo "\tab $RECIP_ADDRESS \\\ " >> $LATEX_FILE
		# Invoice date
		echo '{\bf Date:} \\' >> $LATEX_FILE
		echo '\tab \today \\' >> $LATEX_FILE
		return 0
}

function writting_closing_tags(){
		# writes the closing statements for the latex file
		echo '\end{invoiceTable}' >> $LATEX_FILE
		echo '\end{document}' >> $LATEX_FILE
}


function write_work_tables(){
		# for every worked day and hours worked write the the invoice table
		echo '\begin{invoiceTable}' >> $LATEX_FILE
		# Fee category description
		echo "\feetype{$SERVICE Services}" >> $LATEX_FILE
		# for every day worked 
		for ((i=0; i < ${#DAYS_WORKED[@]}; i++)); do # for every parameter
				# get the date of the last day worked 
				WORK_DATE=$(date --date="last ${DAYS_WORKED[$i]}" +"%B %d, %Y");
				WORK_DATE_NUMERIC=$(date --date="last ${DAYS_WORKED[$i]}" +"%m/%d");
				echo "getting Date for last ${DAYS_WORKED[$i]}: $WORK_DATE";
				HOURS_WORKED=$(get_time_diff ${STARTING_TIMES[$i]} ${ENDING_TIMES[$i]});
				echo "HOURS_WORKED";
				echo $HOURS_WORKED;
				echo "\\hourrow{  ${STARTING_TIMES[$i]} to ${ENDING_TIMES[$i]}  $WORK_DATE_NUMERIC}{$HOURS_WORKED}{$HOUR_RATE}" >> $LATEX_FILE
				echo ""
		done
}

function email_invoice(){
		# Get the subject for the email
		EMAIL_SUBJECT="${NAME}_${SERVICE}_Invoice_$(date --date="today" +"%m-%d-%y")";
		SUBJECT="${EMAIL_SUBJECT// /_}"; # take out any white spaces 
		# change name of invoic pdf
		cp invoice.pdf "$SUBJECT.pdf"; 
		# check if archive dir exist, if not create it 
		[ -d archive  ] || mkdir archive;
		# move to archive
		cp $SUBJECT.pdf archive # move to the archive

		echo "sending mail to $EMAIL_TO"
		# mailx to send the invoice
		s-nail -v -s "$EMAIL_SUBJECT" \
				-S smtp-use-starttls \
				-S ssl-verify=ignore \
				-S smtp-auth=login \
				-S smtp=smtp://smtp.gmail.com:587 \
				-S from="$NAME" \
				-S smtp-auth-user="$GMAIL_FROM" \
				-S smtp-auth-password="$GMAIL_PASSWORD" \
				-S ssl-verify=ignore \
				-a "$SUBJECT.pdf" \
				"$EMAIL_TO" < $EMAIL_MESSAGE_FILE ;

		# check if email was send successfully
		if [  $? -eq 0 ] 
		then 
				echo "email send succesfully!"	;
				rm $SUBJECT.pdf;
		else
				echo "could not send email";
				rm invoice.pdf invoice.log invoice.tex invoice.aux;
				exit 1;
		fi
}

function clean_n_exit(){
		# deletes the file generated an exits without error
		rm invoice.pdf invoice.log invoice.tex invoice.aux;
		exit 0;
}



# load config file
load_config_file;

# check and load parameters
load_parameter $@;

# write header to tex file
write_invoice_header;

# write worked days and hours 
write_work_tables

# writting ending for file
writting_closing_tags;

# compile latex file and show to user
echo "compiling Latex..."
pdflatex invoice.tex && atril invoice.pdf

# confirm user responce
read -r -p "Do you want to send this invoice to $EMAIL_TO? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$  ]]
then
		# if yes, email invoice
		email_invoice 
else
		# else clean and exit
		clean_n_exit
fi


