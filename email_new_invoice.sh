		echo "\hfil{\Huge\bf $NAME}\hfil" >> $LATEX_FILE
		# deletes the file generated an exits without error
else
				-S smtp=smtp://smtp.gmail.com:587 \
# compile latex file and show to user
		echo '{\bf Date:} \\' >> $LATEX_FILE
		echo '\end{document}' >> $LATEX_FILE
		# Invoice date
		echo '\end{invoiceTable}' >> $LATEX_FILE
		[ -d archive  ] || mkdir archive;
		pattern='^([0-2])?[1-9]?[0-9](:[0-5][0-9])?([AaPp][mM])?$';
		# Whitespace
						return 0;
				-S smtp-use-starttls \
		# Invoice recipient
								hours=${args[$i]} # get next arg
function write_work_tables(){
		# load parameters 
		first_time=$(date -d "$1" '+%s');
				else 
				exit 1;
						print_help;
						print_help;
						print_help;
		# move to archive
				-S smtp-auth=login \
declare -a DAYS_WORKED;
				else
				else
				WORK_DATE_NUMERIC=$(date --date="last ${DAYS_WORKED[$i]}" +"%m/%d");
				if ! is_time_regex $first; then 
		SUBJECT="${EMAIL_SUBJECT// /_}"; # take out any white spaces 
				last=$(echo $1 | cut -d '-' -f 2);
				first=$(echo $1 | cut -d '-' -f 1); 
		echo '\tab \today \\' >> $LATEX_FILE
						STARTING_TIMES+=($(date -d"$STARTING_TIME" '+%l:%M%P'));
writting_closing_tags;
# write worked days and hours 
		exit 0;
# confirm user responce
				"$EMAIL_TO" < $EMAIL_MESSAGE_FILE ;
		clean_n_exit
		echo "\tab $RECIP_NAME \\\ " >> $LATEX_FILE
		# return true if it matches regex for a single number or a ranger
		# return true if it matches regex for a single number or a ranger
		echo "\tab $RECIP_ADDRESS \\\ " >> $LATEX_FILE
				echo "HOURS_WORKED";
function is_time_regex(){
		then 
		echo "$ADDRESS \hfill  \\\ " >> $LATEX_FILE
}
}
}
}
}
}
}
}
}
}
}
		hours=$(date -u -d @$(($later_time - $first_time)) '+%H');
write_work_tables
		cp $SUBJECT.pdf archive # move to the archive
				email_new_invoice staurday 12pm-2am friday 12pm sunday 25:00
				echo ""
				source $CONF_FILE;
				-a "$SUBJECT.pdf" \
# writting ending for file
		# Use the custom invoice class (invoice.cls)
		# Fee category description
		case $1 in
		# Define \tab to create some horizontal white space
		}
		else 
				echo "email send succesfully!"	;
		# mailx to send the invoice
				-S smtp-auth-user="$GMAIL_FROM" \
		# else clean and exit
		echo "$CITY, $STATE $ZIP_CODE \hfill $PERSONAL_EMAIL" >> $LATEX_FILE
		rm invoice.pdf invoice.log invoice.tex invoice.aux;
		if [[ $1 =~ "-"  ]]; then # it is range
						echo "could not understand $1 ";






























				fi			
				fi			
function get_time_diff(){
		# return true it it is a weekday
		# begin document 
		# Your address and contact information
read -r -p "Do you want to send this invoice to $EMAIL_TO? [Y/N] " response
				# divide range
		# check if archive dir exist, if not create it 
								load_hours_param $hours;
				rm $SUBJECT.pdf;
		fi
		fi
		fi
		fi
								i=$((i+1));
function load_hours_param(){
function writting_closing_tags(){
		echo '\hrule' >> $LATEX_FILE 
		# Get the subject for the email
# check and load parameters
function email_invoice(){
				echo "Loding config file";
		"""
						STARTING_TIMES+=($(date -d"$first" '+%l:%M%P'));
				echo "could not send email";
		echo '\bigskip\break' >> $LATEX_FILE
				if ! is_time_regex $last; then 
				return 0;
				return 0;
				# get the date of the last day worked 
		for ((i=0; i < ${#DAYS_WORKED[@]}; i++)); do # for every parameter
				done
				echo "\\hourrow{   ${STARTING_TIMES[$i]} to ${ENDING_TIMES[$i]}, $WORK_DATE_NUMERIC}{$HOURS_WORKED}{$HOUR_RATE}" >> $LATEX_FILE
function load_config_file() {
load_config_file;
				rm invoice.pdf invoice.log invoice.tex invoice.aux;
						echo "could not understand $last ";
pdflatex invoice.tex && atril invoice.pdf
		args=("$@"); # load parameter into array
fi
				*)
		echo "checking $1";
function load_parameter(){
						if is_weekday $arg ; then 
				-S from="$NAME" \
function print_help(){
# load config file
				exit 
function write_invoice_header(){
LATEX_FILE="invoice.tex";
						;;
						;;
		# for every worked day and hours worked write the the invoice table
		echo '\begin{document}' >> $LATEX_FILE
#!/bin/bash
		# Horizontal line
						arg=${args[$i]}
		# writes the closing statements for the latex file
		later_time=$(date -d "$2" '+%s');
		# Company providing the invoice
		esac
		# check if email was send successfully
declare -a ENDING_TIMES;
						echo "could not understand $first ";
		cp invoice.pdf "$SUBJECT.pdf"; 
						ENDING_TIMES+=($(date -d"$last" '+%l:%M%P'));
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$  ]]
		return 0
		EMAIL_SUBJECT="${NAME}_${SERVICE}_Invoice_$(date --date="today" +"%m-%d-%y")";
		echo "$hours.$((($minutes*10)/6))"
		# return the difference in time between to given times
		# Recipient's company
						return 1;
		# change name of invoic pdf
		done
		# writes to a latex file using the detail from the config file
				echo "getting Date for last ${DAYS_WORKED[$i]}: $WORK_DATE";
		# if yes, email invoice
				fi
				-S ssl-verify=ignore \
				-S ssl-verify=ignore \
		#--------------------
		#--------------------
		echo """
		echo '\begin{invoiceTable}' >> $LATEX_FILE
						fi
		echo '{\bf Invoice To:} \\' >> $LATEX_FILE
# write header to tex file
EMAIL_MESSAGE_FILE="email_message.txt";
				return 1;
				WORK_DATE=$(date --date="last ${DAYS_WORKED[$i]}" +"%B %d, %Y");
		minutes=$(date -u -d @$(($later_time - $first_time)) '+%M');
function clean_n_exit(){
						ENDING_TIMES+=($(date -d"$1" '+%l:%M%P'));
				HOURS_WORKED=$(get_time_diff ${STARTING_TIMES[$i]} ${ENDING_TIMES[$i]});
		echo '\documentclass{invoice}' > $LATEX_FILE
				monday | thursday | wednesday | thursday | friday | saturday | sunday)
		s-nail -v -s "$EMAIL_SUBJECT" \
								DAYS_WORKED+=("$arg"); # load weekday 
		echo '\def \tab {\hspace*{3ex}}' >> $LATEX_FILE 
				if ! is_time_regex $1; then 
				for ((i=0; i < $#; i++)); do # for every parameter
		# load config file
		if [  $? -eq 0 ] 
		echo "\feetype{$SERVICE Services}" >> $LATEX_FILE
		email_invoice 
		echo "sending mail to $EMAIL_TO"
load_parameter $@;
				echo $HOURS_WORKED;
write_invoice_header;
		echo '\\ \\' >> $LATEX_FILE
then
		else
		else
		else
		if [[ $1 =~ $pattern ]]; then 
declare -a STARTING_TIMES;
CONF_FILE="invoice.conf";
		# HEADING SECTION
			Something went wrong:
echo "compiling Latex..."
				-S smtp-auth-password="$GMAIL_PASSWORD" \
						exit 1;
						exit 1;
						exit 1;
		if test -f $CONF_FILE; then
			plesae enter parameter of the form: 
				echo "Could not find $CONF_FILE";
		# for every day worked 
function is_weekday(){
