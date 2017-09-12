#!/bin/bash
#===================================================================================
#
# FILE: gl0buli.sh
#
# USAGE: gl0buli.sh language
#
# DESCRIPTION:  Generate some gl0buli! Hide this gl0buli in your code to solve
#		unsolvable or strange errors. Thanks to the gl0buli someone
#		will someday solve YOUR problem! You have to believe!
#
# AUTHOR: Florian "Cheatha" Köhler, github.com@cheatha.de
#===================================================================================

input=$*

showHelp() {
	echo "USAGE:"
	echo -e "\tgl0buli.sh language\n"
	echo "Available languages:"
	echo -e "\tphp applescript bash c c++ go ruby java javascript perl batch python puppet swift objc"
}

selectLanguage() {
	case $1 in
		php|c|c++|go|javascript|java|swift|objc)
			tag="doubleslash"
			;;
		applescript)
			tag="doubleminus"
			;;
		bash|ruby|perl|python|puppet)
			tag="hash"
			;;
		batch)
			tag="rem"
			;;
		-h|*)
			showHelp
			;;
	esac
}

selectTag() {
	case $1 in
		doubleslash)
			comment="//"
			;;
		doubleminus)
			comment="--"
			;;
		rem)
			comment="REM"
			;;
		hash)
			comment="#"
			;;
	esac
}

getRandomness() {
	# we expect bs and count as $1 and $2
	# although we are talking about homeopathy
	# "bs" doesn't mean bullshit here
	random=$(dd if=/dev/urandom bs=$1 count=$2)
}

show_patience() {
	# we must be patient and show some patience!
	patience_o_meter="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
	OLDIFS=$IFS
	IFS=:
	set -- $*
	timer=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
	while [ $timer -gt 0 ]
	do
		sleep 1 &
		printf "\r${patience_o_meter:$timer%${#patience_o_meter}:1} %02d:%02d:%02d " $((timer/3600)) $(( (timer/60)%60)) $((timer%60))
		timer=$(( $timer - 1 ))
		wait
	done
	echo
	IFS=$OLDIFS
}

rot13() {
	echo "$1" | tr A-Za-z N-ZA-Mn-za-m
}

sieve() {
	case $1 in
		python)
			echo $2 | tr "acefijmopqruvxzACEFIJMOPQRUVXZ13579" "	                   "
			;;
		*)
			echo $2
			;;
	esac
}

shake() {
	length=${#1}
	declare -a in

	# Create an array, one value for each character
	for (( pos = 0; pos <= $length - 1; pos++ ))
	do
		in=("${in[@]}" ${1:pos:1})
	done
	
	# Randomize order
	out=($(echo ${in[@]} | tr ' ' '\n' | awk 'BEGIN { srand() } { print rand() "\t" $0 }' | sort -n | cut -f2- ))

	( IFS=$''; echo "${out[*]}"; )
}

ascii(){
echo "
        _....._
     .;;'      '-.
   .;;:           '.
  /;;:'             \\
 |;;:    gl0buli    :\ 
|;;:  $gl0buli     :|
|;;::.              ;/
 \;;::.             /
   ';;::.         .'
     '-;;:..  _.-'
         '''''
";
}

html(){
	script_path=`basename $0`
	dir_path=`dirname $0`
	gl0buli_path="$dir_path/your_gl0bulis"

	if [[ ! -d  "$gl0buli_path" ]]; then
		mkdir -p "$gl0buli_path"
	fi

	date=`date +"%Y-%m-%d_%H-%M-%S"`

	html_template="gl0buli.template.html"
	html_template_path="$dir_path/$html_template"

	cat $html_template_path| sed s/\$gl0buli/$gl0buli/ > $gl0buli_path/gl0buli-$date.html

	echo "Your gl0buli can pick up here: $gl0buli_path/gl0buli-$date.html"
}

if [ -z $1 ]; then
	showHelp
	exit
fi


selectLanguage $input
selectTag $tag

echo "Gettting our ingredients…"
echo ""
gl0buli=$(getRandomness 32 10)
echo ""
echo "Done."

echo "This gl0buli has a strong binding to time and space!"
read -p "Where are you now? " LOCATION

time=$(date +"%Y-%m-%d %H:%M:%S")
echo "Your time is now: $time"

space=$(df / | tail -n 1 | awk '/\s*/ { print $4 }')
echo "The computer has chosen its space to be: $space"

echo "We now combine human and computer space for better compatibility"
space="$space$LOCATION"

echo "Now we merge gl0buli with time and space"
gl0buli="$gl0buli $space $time"

echo "Insert some special ingredients"
gl0buli="$gl0buli BUY MORE gl0buli!"

echo "We don't want to be too specific about our gl0buli"
gl0buli=$(echo "$gl0buli" | shasum)

echo "Get the 'most important parts*' out of our gl0buli."
echo "*(Ancient knowledge from a tibetan monk)"
gl0buli=$(echo "$gl0buli" | cut -c1-10)

echo "Now rotate gl0buli clockwise"
gl0buli=$(rot13 "$gl0buli")

echo "We need a little patience"
patience=`awk 'BEGIN{srand();print int(rand()*(30-10))+10 }'`
echo "Now showing patience for $patience seconds"
show_patience "00:00:$patience"
echo "That's enough. Time is money!"

echo "Add some fate. This fate was once a diceroll."
echo "Your fate was selected by a fair diceroll!"
diceroll="5"
echo "Your fate: $diceroll"
gl0buli="$gl0buli$diceroll"

echo "Potentisation of $gl0buli"
echo "This one is suuuuper important!"
for magic in {1..5}
do
	gl0buli+="$gl0buli$magic"
done

echo "Oooops, our gl0buli is too large. Let's pick the most important…"
echo "Yeah, this ancient monk stuff"
gl0buli=$(echo "$gl0buli" | cut -c1-10)

echo "Let's shake the gl0buli!"
oldgl0buli=$gl0buli
gl0buli=$(shake "$gl0buli")
echo "Whoo, $gl0buli looks much better than $oldgl0buli!"

gl0buli=$(sieve "$input" "$gl0buli")

echo "CONGRATULATIONS! Now you have your own gl0buli!"
echo ""
echo "$comment"
echo "$comment This is a \$gl0buli. It will help to solve your coding errors!"
echo "$comment Copy this to your code and someday someone will somewhere solve your errors."
echo "$comment Just believe in it!"
echo "$comment $gl0buli"
echo "$comment"
echo ""

echo "Do you want to print your awesome gl0buli as ASCII or save it as HTML?"
echo "1) Show me some ASCII!"
echo "2) I'd like to have some fancy HTML!"
echo "3) None of the above, I'm fine. Thanks!"


while true; do
	read -p "Your choice: " -n 1 print
	echo ""

	case $print in
		1)
		echo "Here you go:"
		ascii
		break
		;;
		2)
		echo "Your gl0buli will be safed in the gl0bulis directory."
		html
		break
		;;
		3)
		echo "Fine. Enjoy your gl0buli!"
		break
		;;
		*)
		echo "Please choose your gl0buli output format!"
		;;
	esac
done

echo "Send gl0buli.sh within 24 hours to 12 friends or something really bad will happen!"
echo "Really."

# Destroy all evidence of our holistic variable $gl0buli
unset gl0buli
unset random
unset tag
unset comment
