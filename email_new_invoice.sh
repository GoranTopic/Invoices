	echo "$ADDRESS \hfill  \\\ " >> $LATEX_FILE
	for ((i=0; i < ${#DAYS_WORKED[@]}; i++)); do # for every parameter
	# else clean and exit
	# change name of invoic pdf
	# Invoice date
			echo "could not send email";
function load_config_file() {
	# load parameters 
			fi
	# Fee category description
	# move to archive
	# Recipient's company
declare -a DAYS_WORKED;
		then 
	email_invoice 
	later_time=$(date -d "$2" '+%s');
		monday | thursday | wednesday | thursday | friday | saturday | sunday)
	else
	else
function write_invoice_header(){
then
	"""
function load_hours_param(){
write_work_tables
function email_invoice(){






























		exit 
		return 1;
	# return true it it is a weekday
echo "compiling Latex..."
	exit 0;
		-S ssl-verify=ignore \
		-S ssl-verify=ignore \
# check and load parameters
writting_closing_tags;
		-S smtp-auth-user="$GMAIL_FROM" \
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$  ]]
else
	first_time=$(date -d "$1" '+%s');
	# HEADING SECTION
			echo "could not understand $1";
		if ! is_time_regex $1; then 
# write worked days and hours 
	echo "$hours.$((($minutes*10)/6))"
fi
			return 0;
	case $1 in
	echo '\hrule' >> $LATEX_FILE 
	if [[ $1 =~ "-"  ]]; then # it is range
		-S smtp-auth-password="$GMAIL_PASSWORD" \
				hours=${args[$i]} # get next arg
			ENDING_TIMES+=($(date -d"$last" '+%l:%M%P'));
		else
		else
		else
	echo '\tab \today \\' >> $LATEX_FILE
	[ -d archive  ] || mkdir archive;
	echo '\documentclass{invoice}' > $LATEX_FILE
	echo '\begin{invoiceTable}' >> $LATEX_FILE
			if is_weekday $arg ; then 
		if ! is_time_regex $last; then 
	# if yes, email invoice
# writting ending for file
	# check if archive dir exist, if not create it 
	# Invoice recipient
	# load config file
	# Horizontal line
pdflatex invoice.tex && atril invoice.pdf
		first=$(echo $1 | cut -d '-' -f 1); 
	# Get the subject for the email
# write header to tex file
	echo "$CITY, $STATE $ZIP_CODE \hfill $PERSONAL_EMAIL" >> $LATEX_FILE
		-S smtp=smtp://smtp.gmail.com:587 \
	echo '\\ \\' >> $LATEX_FILE
function is_time_regex(){
	# deletes the file generated an exits without error
		last=$(echo $1 | cut -d '-' -f 2);
			echo "email send succesfully!"	;
		HOURS_WORKED=$(get_time_diff ${STARTING_TIMES[$i]} ${ENDING_TIMES[$i]});
		-S smtp-use-starttls \
function is_weekday(){
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
declare -a ENDING_TIMES;
LATEX_FILE="invoice.tex";
	echo "\tab $RECIP_ADDRESS \\\ " >> $LATEX_FILE
	args=("$@"); # load parameter into array
write_invoice_header;
	# Define \tab to create some horizontal white space
load_config_file;
			print_help;
			print_help;
			print_help;
	echo "\tab $RECIP_NAME \\\ " >> $LATEX_FILE
			rm invoice.pdf invoice.log invoice.tex invoice.aux;
	# writes to a latex file using the detail from the config file
	echo '\end{invoiceTable}' >> $LATEX_FILE
	# return the difference in time between to given times
	echo '\end{document}' >> $LATEX_FILE
	else 
				i=$((i+1));
# compile latex file and show to user
		done
		# check if email was send successfully
function get_time_diff(){
	# mailx to send the invoice
	s-nail -v -s "$EMAIL_SUBJECT" \
			STARTING_TIMES+=($(date -d"$first" '+%l:%M%P'));
		echo "getting Date for last ${DAYS_WORKED[$i]}: $WORK_DATE";
		echo "\\hourrow{   ${STARTING_TIMES[$i]} to ${ENDING_TIMES[$i]}, $WORK_DATE_NUMERIC}{$HOURS_WORKED}{$HOUR_RATE}" >> $LATEX_FILE
	echo '\begin{document}' >> $LATEX_FILE
		WORK_DATE_NUMERIC=$(date --date="last ${DAYS_WORKED[$i]}" +"%m/%d");
	# Use the custom invoice class (invoice.cls)
	echo '\bigskip\break' >> $LATEX_FILE
function clean_n_exit(){
CONF_FILE="invoice.conf";
		WORK_DATE=$(date --date="last ${DAYS_WORKED[$i]}" +"%B %d, %Y");
	cp $SUBJECT.pdf archive # move to the archive
read -r -p "Do you want to send this invoice to $EMAIL_TO? [Y/N] " response
# load config file
function load_parameter(){
			exit 1;
			exit 1;
			exit 1;
			exit 1;
# confirm user responce
		# get the date of the last day worked 
		else 
			rm $SUBJECT.pdf;
		echo ""
declare -a STARTING_TIMES;
	echo "\hfil{\Huge\bf $NAME}\hfil" >> $LATEX_FILE
	echo "sending mail to $EMAIL_TO"
	# return true if it matches regex for a single number or a ranger
	# return true if it matches regex for a single number or a ranger
	echo """
	pattern='^([0-2])?[1-9]?[0-9](:[0-5][0-9])?([AaPp][mM])?$';
	SUBJECT="${EMAIL_SUBJECT// /_}"; # take out any white spaces 
	plesae enter parameter of the form: 
		if [  $? -eq 0 ] 
			echo "could not understand $first ";
	esac
		"$EMAIL_TO" < $EMAIL_MESSAGE_FILE ;
				DAYS_WORKED+=("$arg"); # load weekday 
			return 1;
			STARTING_TIMES+=($(date -d"$STARTING_TIME" '+%l:%M%P'));
		*)
function writting_closing_tags(){
	if test -f $CONF_FILE; then
			arg=${args[$i]}
	# for every worked day and hours worked write the the invoice table
#!/bin/bash
	echo "checking $1";
				load_hours_param $hours;
		fi
		fi
	return 0
			echo "could not understand $last";
		echo "Could not find $CONF_FILE";
		# divide range
load_parameter $@;
	if [[ $1 =~ $pattern ]]; then 
	minutes=$(date -u -d @$(($later_time - $first_time)) '+%M');
		for ((i=0; i < $#; i++)); do # for every parameter
	fi
	fi
	fi
	}
	}
	cp invoice.pdf "$SUBJECT.pdf"; 
		source $CONF_FILE;
	echo "\feetype{$SERVICE Services}" >> $LATEX_FILE
	echo '{\bf Date:} \\' >> $LATEX_FILE
	echo '{\bf Invoice To:} \\' >> $LATEX_FILE
	rm invoice.pdf invoice.log invoice.tex invoice.aux;
		if ! is_time_regex $first; then 
		echo "Loding config file";
	# Your address and contact information
	clean_n_exit
	done
	# begin document 
		-a "$SUBJECT.pdf" \
	#--------------------
	#--------------------
		return 0;
		return 0;
	email_new_invoice staurday 12pm-2am friday 12pm sunday 25:00
		echo "HOURS_WORKED";
		-S from="$NAME" \
		echo $HOURS_WORKED;
	# writes the closing statements for the latex file
			;;
			;;
		-S smtp-auth=login \
function print_help(){
EMAIL_MESSAGE_FILE="email_content.txt";
		fi			
		fi			
			ENDING_TIMES+=($(date -d"$1" '+%l:%M%P'));
function write_work_tables(){
	EMAIL_SUBJECT="${NAME}_${SERVICE}_Invoice_$(date --date="today" +"%m-%d-%y")";
	Something went wrong:
	# Company providing the invoice
	hours=$(date -u -d @$(($later_time - $first_time)) '+%H');
	# for every day worked 
	echo '\def \tab {\hspace*{3ex}}' >> $LATEX_FILE 
	# Whitespace
