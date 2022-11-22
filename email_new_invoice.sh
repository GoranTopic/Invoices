	first_time=$(date -d "$1" '+%s');
	echo '\begin{document}' >> $LATEX_FILE
	else 
	# writes to a latex file using the detail from the config file
declare -a STARTING_TIMES;
	# for every worked day and hours worked write the the invoice table
	echo '\bigskip\break' >> $LATEX_FILE
			fi
		echo ""
	echo "sending mail to $EMAIL_TO"
pdflatex invoice.tex && atril invoice.pdf
		*)
			echo "email send succesfully!"	;
		echo "HOURS_WORKED";
	done
echo "compiling Latex..."
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$  ]]
	hours=$(date -u -d @$(($later_time - $first_time)) '+%H');
fi
function load_parameter(){
			print_help;
			print_help;
			print_help;
		if [  $? -eq 0 ] 
	fi
	fi
	fi
# write worked days and hours 
				DAYS_WORKED+=("$arg"); # load weekday 
			if is_weekday $arg ; then 
	plesae enter parameter of the form: 
	# return true it it is a weekday
	echo "$hours.$((($minutes*10)/6))"
		echo "Loding config file";
		fi
		fi
		else
		else
		else
		echo "\\hourrow{   ${STARTING_TIMES[$i]} to ${ENDING_TIMES[$i]}, $WORK_DATE_NUMERIC}{$HOURS_WORKED}{$HOUR_RATE}" >> $LATEX_FILE
		else 
LATEX_FILE="invoice.tex";
function writting_closing_tags(){
		-S smtp-auth=login \
		WORK_DATE_NUMERIC=$(date --date="last ${DAYS_WORKED[$i]}" +"%m/%d");
# confirm user responce
		"$EMAIL_TO" < $EMAIL_MESSAGE_FILE ;
	echo "\tab $RECIP_ADDRESS \\\ " >> $LATEX_FILE
	# move to archive
			ENDING_TIMES+=($(date -d"$last" '+%l:%M%P'));
	later_time=$(date -d "$2" '+%s');
		HOURS_WORKED=$(get_time_diff ${STARTING_TIMES[$i]} ${ENDING_TIMES[$i]});
			echo "could not understand $1";
	# load config file
		if ! is_time_regex $last; then 
function get_time_diff(){
else
function is_weekday(){
		return 1;
function email_invoice(){
		done
	echo """
		monday | thursday | wednesday | thursday | friday | saturday | sunday)
	# Define \tab to create some horizontal white space
# writting ending for file
load_parameter $@;
		-S smtp-auth-password="$GMAIL_PASSWORD" \
		for ((i=0; i < $#; i++)); do # for every parameter
	else
	else
	# return the difference in time between to given times
	# deletes the file generated an exits without error
	# Invoice recipient
	email_invoice 
		# get the date of the last day worked 
		-a "$SUBJECT.pdf" \
	echo '{\bf Date:} \\' >> $LATEX_FILE
	echo '{\bf Invoice To:} \\' >> $LATEX_FILE
		return 0;
		return 0;
function load_hours_param(){
# check and load parameters
read -r -p "Do you want to send this invoice to $EMAIL_TO? [Y/N] " response
	# writes the closing statements for the latex file
	echo '\tab \today \\' >> $LATEX_FILE
# write header to tex file
load_config_file;
		fi			
		fi			
	rm invoice.pdf invoice.log invoice.tex invoice.aux;
then
			ENDING_TIMES+=($(date -d"$1" '+%l:%M%P'));
	# else clean and exit
	# Company providing the invoice
	# if yes, email invoice






























function print_help(){
	minutes=$(date -u -d @$(($later_time - $first_time)) '+%M');
	}
	}
		first=$(echo $1 | cut -d '-' -f 1); 
	# change name of invoic pdf
	# return true if it matches regex for a single number or a ranger
	# return true if it matches regex for a single number or a ranger
	clean_n_exit
	s-nail -v -s "$EMAIL_SUBJECT" \
	# Your address and contact information
	case $1 in
	SUBJECT="${EMAIL_SUBJECT// /_}"; # take out any white spaces 
	if [[ $1 =~ $pattern ]]; then 
	echo "\hfil{\Huge\bf $NAME}\hfil" >> $LATEX_FILE
	for ((i=0; i < ${#DAYS_WORKED[@]}; i++)); do # for every parameter
	echo '\begin{invoiceTable}' >> $LATEX_FILE
CONF_FILE="invoice.conf";
function write_work_tables(){
	pattern='^([0-2])?[1-9]?[0-9](:[0-5][0-9])?([AaPp][mM])?$';
	echo '\hrule' >> $LATEX_FILE 
			return 0;
	args=("$@"); # load parameter into array
		-S smtp-auth-user="$GMAIL_FROM" \
	email_new_invoice staurday 12pm-2am friday 12pm sunday 25:00
declare -a ENDING_TIMES;
writting_closing_tags;
			rm $SUBJECT.pdf;
	# check if archive dir exist, if not create it 
			echo "could not understand $first ";
				load_hours_param $hours;
			exit 1;
			exit 1;
			exit 1;
			exit 1;
	echo '\end{invoiceTable}' >> $LATEX_FILE
			;;
			;;
			echo "could not send email";
	# Invoice date
		echo "Could not find $CONF_FILE";
			return 1;
	echo "$CITY, $STATE $ZIP_CODE \hfill $PERSONAL_EMAIL" >> $LATEX_FILE
				i=$((i+1));
	esac
	EMAIL_SUBJECT="${NAME}_${SERVICE}_Invoice_$(date --date="today" +"%m-%d-%y")";
		last=$(echo $1 | cut -d '-' -f 2);
		-S from="$NAME" \
	[ -d archive  ] || mkdir archive;
		source $CONF_FILE;
	if test -f $CONF_FILE; then
	if [[ $1 =~ "-"  ]]; then # it is range
			rm invoice.pdf invoice.log invoice.tex invoice.aux;
# load config file
	echo '\documentclass{invoice}' > $LATEX_FILE
	# for every day worked 
	echo "$ADDRESS \hfill  \\\ " >> $LATEX_FILE
write_work_tables
# compile latex file and show to user
function clean_n_exit(){
	exit 0;
function is_time_regex(){
	Something went wrong:
	# Horizontal line
	# HEADING SECTION
		if ! is_time_regex $first; then 
function write_invoice_header(){
		then 
	# mailx to send the invoice
	echo "checking $1";
		WORK_DATE=$(date --date="last ${DAYS_WORKED[$i]}" +"%B %d, %Y");
	echo "\tab $RECIP_NAME \\\ " >> $LATEX_FILE
declare -a DAYS_WORKED;
	# Recipient's company
	echo '\\ \\' >> $LATEX_FILE
write_invoice_header;
	cp invoice.pdf "$SUBJECT.pdf"; 
	echo '\end{document}' >> $LATEX_FILE
			STARTING_TIMES+=($(date -d"$STARTING_TIME" '+%l:%M%P'));
	#--------------------
	#--------------------
	cp $SUBJECT.pdf archive # move to the archive
			echo "could not understand $last";
	# Whitespace
	echo "\feetype{$SERVICE Services}" >> $LATEX_FILE
	"""
			arg=${args[$i]}
		-S ssl-verify=ignore \
		-S ssl-verify=ignore \
		if ! is_time_regex $1; then 
	# Use the custom invoice class (invoice.cls)
function load_config_file() {
	return 0
EMAIL_MESSAGE_FILE="email_content.txt";
		# check if email was send successfully
	# begin document 
		echo $HOURS_WORKED;
			STARTING_TIMES+=($(date -d"$first" '+%l:%M%P'));
	# Fee category description
		# divide range
	# Get the subject for the email
		-S smtp-use-starttls \
	echo '\def \tab {\hspace*{3ex}}' >> $LATEX_FILE 
		exit 
				hours=${args[$i]} # get next arg
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
		-S smtp=smtp://smtp.gmail.com:587 \
	# load parameters 
		echo "getting Date for last ${DAYS_WORKED[$i]}: $WORK_DATE";
#!/bin/bash
