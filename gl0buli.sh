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

# Enable unofficial bash strict mode
# More info: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

input=${1:-alpha}

showHelp() {
	echo "USAGE:"
	echo -e "\\tgl0buli.sh language\\n"
	echo "Available languages:"
	echo -e "\\tphp applescript bash c c++ go ruby java javascript perl batch python puppet swift objc rust"
	exit 0
}

selectLanguage() {
	case "${input}" in
		php|c|c++|go|javascript|java|swift|objc|rust)
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
			tag="none"
			;;
	esac
}

selectTag() {
	case "${tag}" in
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
	random=$(dd if=/dev/urandom bs="$1" count="$2")
	echo "${random}"
}

show_patience() {
	# we must be patient and show some patience!
	patience_o_meter="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
	OLDIFS="${IFS}"
	IFS=:
	set -- $@
	timer=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
	while [[ "${timer}" -gt 0 ]]
	do
		sleep 1 &
		printf "\\r${patience_o_meter:${timer}%${#patience_o_meter}:1} %02d:%02d:%02d " $((timer/3600)) $(( (timer/60)%60)) $((timer%60))
		timer="$(( timer - 1 ))"
		wait
	done
	echo
	IFS="${OLDIFS}"
}

rot13() {
	rot13=$(echo "${1}" | tr A-Za-z N-ZA-Mn-za-m)
	echo ${rot13}
}

sieve() {
	case "${1}" in
		python)
			echo "${2}" | tr "acefijmopqruvxzACEFIJMOPQRUVXZ13579" "	                   "
			;;
		*)
			echo "${2}"
			;;
	esac
}

colorize() {
echo -e -n "\033[1;36m${1}\033[0m"
}

shake() {
	length="${#1}"
	declare -a in

	# Create an array, one value for each character
	for (( pos = 0; pos <= length - 1; pos++ ))
	do
		in=(${in[@]+"${in[@]}"} "${1:pos:1}")
	done

	# Randomize order
	out=($(echo "${in[*]}" | tr ' ' '\n' | awk 'BEGIN { srand() } { print rand() "\t" $0 }' | sort -n | cut -f2- ))

	( IFS=$''; echo "${out[*]}"; )
}

plain(){
echo "${comment} $(colorize "${gl0buli}")"
}

ascii(){
echo "
        _....._
     .;;'      '-.
   .;;:           '.
  /;;:'             \\
 |;;:    gl0buli    :\\ 
|;;:  ${gl0buli}     :|
|;;::.              ;/
 \\;;::.             /
   ';;::.         .'
     '-;;:..  _.-'
         '''''
";
}

html(){
	dir_path=$(dirname "${0}")
	gl0buli_path="${dir_path}/your_gl0bulis"

	if [[ ! -d  "${gl0buli_path}" ]]; then
		mkdir -p "${gl0buli_path}"
	fi

	date=$(date +"%Y-%m-%d_%H-%M-%S")

	html_template="gl0buli.template.html"
	html_template_path="${dir_path}/${html_template}"

	sed s/INSERT_GL0BULI_HERE/"${gl0buli}"/ "${html_template_path}" > "${gl0buli_path}/gl0buli-${date}.html"

	echo "Your gl0buli can pick up here: ${gl0buli_path}/gl0buli-${date}.html"
}

if [[ -z "${input}" ]]; then
	showHelp
	exit
fi


selectLanguage
selectTag

echo "Getting our first ingredients…"
gl0buli="$(getRandomness 10)"
echo "Done. We've got $(colorize ${gl0buli}). That's a good start!"

echo -e "\nThis gl0buli has a strong binding to time and space!"
read -rp "Where are you now? " LOCATION

echo -e "\nHope you've got nice weather at ${LOCATION}!"

if command -v curl &> /dev/null
then
	echo "By the way: Should we check the weather for ${LOCATION} on wttr.in?"
	echo "(It's perfectly fine to say 'no'! :)"

	while true; do
		echo ""
		read -rp "Type 'y' for 'yes' or 'n' for 'no': " -n 1 wttr
		echo ""
			case "${wttr}" in
				y|Y)
					curl -s wttr.in/${LOCATION}\?0
					break
					;;
				*)
					echo "Fine, we'll move on. Who cares about the weather anyway?"
					break
				;;
		esac
	done
fi

time=$(date +"%Y-%m-%d %H:%M:%S")
echo -e "\nYour time is now: $(colorize ${time}). Thats an important part, we'll add it to our gl0buli. Later."

space=$(df / | tail -n 1 | awk '/\s*/ { print $4 }')
echo "The computer has chosen its space to be: $(colorize ${space})"
echo "(Really, don't know what this means, but who does understand computers anyway?)"

echo -e "\nWe now combine human and computer space for better compatibility"
echo "Combine $(colorize "${LOCATION}") and $(colorize ${space})"
newspace="${space} ${LOCATION}"

echo -e "\nNow we merge gl0buli with time and space"
gl0buli="${gl0buli} ${newspace} ${time}"
echo "Whoohoo, no we've got $(colorize ${gl0buli})."

echo -e "\nInsert some _special_ ingredients"
gl0buli="${gl0buli} BUY MORE gl0buli!"
echo "Look how tasty it looks now: $(colorize ${gl0buli})"

echo -e "\nWe don't want to be too specific about our gl0buli"
gl0buli=$(echo "${gl0buli}")

echo -e "\nGet the 'most important parts*' out of our gl0buli."
echo "*(Ancient knowledge from a tibetan monk)"
gl0buli=$(echo "${gl0buli}" | cut -c1-10)

echo -e "\nIt was transformed into this: $(colorize ${gl0buli})"
echo "Now rotate gl0buli clockwise"
gl0buli=$(rot13 "${gl0buli}")

echo -e "\nWe need a little patience"
patience=$(awk 'BEGIN{srand();print int(rand()*(30-10))+10 }')
echo "Now showing patience for ${patience} seconds"
show_patience "00:00:${patience}"
echo "That's enough. Time is money!"

echo -e "\nAdd some fate. This fate was once a diceroll."
echo "Your fate was selected by a fair diceroll!"
fair_diceroll="5"
echo "Your fate: ${fair_diceroll}"
gl0buli="${gl0buli}${fair_diceroll}"

echo -e "\nPotentisation of $(colorize "${gl0buli}")"
echo "This one is suuuuper important!"
for magic in {1..5}
do
	gl0buli+="${gl0buli}${magic}"
done

echo -e "\nOooops, our gl0buli is too large. Let's pick the most important…"
echo "Yeah, this ancient monk stuff"
gl0buli=$(echo "${gl0buli}" | cut -c1-10)

echo -e "\nLet's shake the gl0buli!"
oldgl0buli=$gl0buli
gl0buli=$(shake "${gl0buli}")
echo "Whoo, $(colorize "${gl0buli}") looks much better than $(colorize ${oldgl0buli})!"

gl0buli=$(sieve "${input}" "${gl0buli}")

echo "CONGRATULATIONS! Now you have your own gl0buli!"
echo ""
echo "${comment}"
echo "${comment} This is a \$gl0buli. It will help to solve your coding errors!"
echo "${comment} Copy this to your code and someday someone will somewhere solve your errors."
echo "${comment} Just believe in it!"
echo "${comment} $(colorize ${gl0buli})"
echo "${comment}"
echo ""

echo -e "\nDo you want to print your awesome gl0buli as ASCII or save it as HTML?"
echo "1) Show me some ASCII!"
echo "2) I'd like to have some fancy HTML!"
echo "3) Just as plain text, please!"
echo "4) None of the above, I'm fine. Thanks!"
echo ""

while true; do
	read -rp "Your choice: " -n 1 print
	echo ""

	case "${print}" in
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
		echo "This is your beautiful new gl0buli: $(colorize "${gl0buli}")"
		break
		;;
		4)
		echo "Fine. Enjoy your gl0buli!"
		break
		;;
		*)
		echo "Please choose your gl0buli output format!"
		;;
	esac
done

echo -e "\nSend gl0buli.sh within 24 hours to 12 friends or something really bad will happen!"
sleep 4
echo "Really."
sleep 4
echo "Really?"

# Destroy all evidence of our holistic variable $gl0buli
unset gl0buli
unset random
unset tag
unset comment
