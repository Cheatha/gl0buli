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
	length="${1}"
	random=$(head -c 100000 /dev/urandom | LC_ALL=C tr -dc 'A-Za-z0-9' | head -c "${length}")
	echo ${random}
}

get_dilution() {
	case "${1}" in
		C)
		dilution_shakes="10"
		dilution_ratio="100"
		;;
		D)
		dilution_shakes="10"
		dilution_ratio="10"
		;;
		Q)
		dilution_shakes="100"
		dilution_ratio="50000"
		;;
		*)
		echo "No dilution given. Exit"
		exit 1
		;;
	esac
}

set_dilution() {
	for dilution in D C Q; do
		get_dilution "${dilution}"
		echo "- $(colorize ${dilution}): 1:${dilution_ratio} potency per round, ${dilution_shakes} shakes"
	done
}

set_potency() {
	case "${1}" in
		C|c)
			common_potency_min=1
			common_potency_max=1000
		;;
		d|D)
			common_potency_min=1
			common_potency_max=1000
		;;
		q|Q)
			common_potency_min=1
			common_potency_max=160
		;;
	esac

	echo -e "\nNow we need to choose a suitable potency. With $(colorize $(echo ${1}|awk '{ print toupper($0) }')) dilution potencys between ${common_potency_min} and ${common_potency_max} are common."

		read -rp "Select potency (${common_potency_min} and ${common_potency_max}): " -n 4 potency
		echo ""

	if [[ -z ${potency} ]]; then
		echo "Please choose a potency between ${common_potency_min} and ${common_potency_max}"
		set_potency "${1}"
	fi

	if (( "${potency}" >= "${common_potency_min}" && "${potency}" <= "${common_potency_max}" )); then
		my_potency="${potency}"
		break
	else
		echo "Potency out of range! Start again."
		set_potency "${1}"
	fi

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

start_dilusion(){
	gl0buli="$(echo ${gl0buli}| tr -d '[:space:]')"
	initial_size="${#gl0buli}"
	initial_gl0buli="${gl0buli}"

	for round in $( seq 1 "${my_potency}"); do
		echo -e "\nRound: ${round}"

		echo "Add random characters which don't contain any characters from our gl0buli"
		dirty_stuff="$(getRandomness "$(expr "${dilution_length}" \* 2)")"
		remove_chars="$(echo "${gl0buli}${initial_gl0buli}" | grep -o . | sort | uniq | tr -d "\n")"

		clean_stuff="${dirty_stuff}"
		while read -n 1 char ; do
			if [[ ! -z "${char}" ]]; then
				clean_stuff="$(echo ${clean_stuff}| tr -d ${char})"
			fi
		done <<< "$(echo "${remove_chars}")"

		clean_stuff=${clean_stuff:0:${dilution_length}}
		[[ "${verbose}" == "Y" ]] && echo -e "We've got this clean stuff: ${clean_stuff}\n"
		echo "Now: Mix and shake!"

dance_1="\t(•_•)
\t<) )╯
\t/ \ "

dance_2="\t(•_•)
\t\( (>
\t / \ "
		for shake in $(seq "${dilution_shakes}");  do
			[ $((shake%2)) -eq 0 ] && echo -e "\n   \o\ SHAKE! \o\ \n\n${dance_1}\n" || echo -e "\n   /o/ SHAKE! /o/ \n\n${dance_2}\n"
			mixture="$(shake "${gl0buli}${clean_stuff}")"
		done

		echo "Extract new gl0buli!"
		gl0buli=$(echo ${mixture}|cut -c1-${initial_size})

		echo "New gl0buli is: $(colorize ${gl0buli})."
		sleep 2
	done
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

echo -e "\nAdd some fate. This fate was once a diceroll."
echo "Your fate was selected by a fair diceroll!"
fair_diceroll="5"
echo "Your fate: ${fair_diceroll}"
gl0buli="${gl0buli}${fair_diceroll}"

echo -e "\nWe don't want to be too specific about our gl0buli. Let's do an hash encrpytion! It's super safe!"
gl0buli=$(echo "${gl0buli}"|shasum| cut -c1-$(expr ${fair_diceroll} \* 2))
echo "I'm sure nobody can hack this: $(colorize ${gl0buli})"

echo -e "\nGet the 'most important parts*' out of our gl0buli."
echo "*(Ancient knowledge from a tibetan monk)"
gl0buli=$(echo "${gl0buli}" | cut -c1-10)

echo -e "\nIt was transformed into this: $(colorize ${gl0buli})"
echo "Now rotate gl0buli clockwise"
gl0buli=$(rot13 "${gl0buli}")
echo "It is now $(colorize "${gl0buli}")"

echo -e "\nWe need a little patience"
patience=$(awk 'BEGIN{srand();print int(rand()*(30-10))+10 }')
echo "Now showing patience for ${patience} seconds"
show_patience "00:00:${patience}"
echo "That's enough. Time is money!"

echo -e "\nFake potentisation of $(colorize "${gl0buli}")"
echo "This one is suuuuper important!"
for magic in $( seq 1 5)
do
	gl0buli="${gl0buli}-${magic}"
done

echo -e "\nOooops, our gl0buli $(colorize "${gl0buli}") is too large. Let's pick the most important…"
gl0buli=$(echo "${gl0buli}" | cut -c1-10)
echo "Yeah, this ancient monk stuff. It's now $(colorize "${gl0buli}")"

echo -e "\nLet's shake the gl0buli!"
oldgl0buli="${gl0buli}"
gl0buli=$(shake "${gl0buli}")
echo "Whoo, $(colorize "${gl0buli}") looks much better than $(colorize ${oldgl0buli})!"

gl0buli=$(sieve "${input}" "${gl0buli}")

echo -e "\n⋆ ✢ ✣ ✤ ✥ ✦ ✧ ✩ ✪ ✫ ✬ ✭ ✮ ✯ ✰ ★ ۞"
echo "We've successfully prepared our source substance."
echo "Let's begin with out homeopathy according to Hahnemann."
echo -e -n "Our gl0buli looks like this: $(colorize ${gl0buli}).\n"
echo -e "Next we will need our dilution. You can choose between these dilutions, like in a real world homeopathy scenario:\n"

set_dilution

while true; do
	echo ""
	read -rp "Your choice: " -n 1 dilution
	dilution="$(echo ${dilution}|awk '{ print toupper($0) }')"

	echo ""
	case "${dilution}" in
		Q)
			echo "$(colorize 'WARNING!') You have chosen $(colorize $(echo ${dilution})) as diltion. This means we will work with pretty large strings."
			echo "This will take a while. It will slow down your device. Please check your CPU temperature, load and battery level."
			echo "You can cancel this script anytime with $(colorize 'CTRL+C')"
			echo -e "Who cares about warnings in homeopathy, right? Let's move on!\n"
			read -rp "Press any key to continue " -n1 yolo
			get_dilution ${dilution}
			set_potency ${dilution}
			;;
		C|D)
			get_dilution ${dilution}
			set_potency ${dilution}
			;;
		*)
			echo "Please choose your dilution! Press C, D or Q: "
		;;
	esac
done

echo -e "\nYou have chosen $(colorize $(echo ${dilution}|awk '{ print toupper($0) }')${my_potency})."
echo "This means we will potentize your poor gl0buli according to homeopathy."

dilution_length=$(expr ${dilution_ratio} \* ${#gl0buli})
echo "- First we dilute the gl0buli, which has a lenght of $(colorize "${#gl0buli} characters"), with $(colorize "${dilution_length} random characters")"
sleep 2
echo "- Then we will $(colorize "shake it")"
sleep 2
echo "- Next we will extract $(colorize "${#gl0buli} random characters") from it"
sleep 4
echo -e "\nThat's the first round. Just the first one."
sleep 2
echo "We'll repeat this for another $(colorize "$(expr ${my_potency} - 1)") rounds."

echo -e "Do you want to see the characters we mix your gl0buli with? Might produce a lot of output."
echo -e "But it's nice to get a glimpse of what we are talking about.\n"
read -rp "Press $(colorize "Y") to show all or any other key to hide: " -n1 verbose
verbose=$(echo ${verbose}|awk '{ print toupper($0) }')

echo -e "\nHave a last look at your beautiful gl0buli $(colorize ${gl0buli}) before we start.\n"
read -rp "Press any key to continue " -n1 NSA_CIA_FBI_KGB_BND_MI5_GCHQ

start_dilusion

common=$(comm -12 <(fold -w1 <<< ${gl0buli} | sort -u) <(fold -w1 <<< ${initial_gl0buli} | sort -u) | tr -d '\n')
echo -e "\nAll rounds done!"
echo "Our initial gl0buli was $(colorize ${initial_gl0buli}), now we've got $(colorize ${gl0buli}). They share $(colorize "${#common} characters")."

echo -e "\n$(colorize "CONGRATULATIONS! Now you have your own gl0buli!")"

echo -e "\n${comment}"
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
		echo "Your gl0buli will be saved in the gl0bulis directory."
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

echo -e "\nWe've finished our gl0buli in form of a dilution fluid. Now we have to apply this fluid onto sugar."
echo -e "Usally you mix it 1:100, so 1ml dilution fluid will be applied onto 100g of sugar pills, which contains about 110-130 pills."
echo -e "Please apply it accordingly!\n"

echo -e "\nPlease like and subscribe and send gl0buli.sh within 24 hours to 12 friends or something really bad will happen!"
sleep 4
echo "Really."
sleep 4
echo "Really?"

# Destroy all evidence of our holistic variable $gl0buli
unset gl0buli
unset random
unset tag
unset comment
