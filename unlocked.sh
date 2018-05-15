#!/bin/bash
usage="$(basename "$0") [-d]

where: 
  -h              Dispaly this help message
  -d              Daemon Mode
\n"

while getopts ':h:d' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    d) daemon=TRUE
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

start_volume=`osascript -e 'get volume settings'|awk -F',' '{print \$1}'|awk -F':' '{print \$2}'`
desired_volume=75
sayings=("I really should lock my computer"\ 
    "I got hacked because I have a lack of technical skillz"\ 
    "I just farted" "why is everybody looking at me"\ 
    "I voted for Donald Trump"\ 
    "my imaginary friends tell me that i have a certain jen a say qua"\ 
    "OOOOklahoma, where the wind comes sweepin' down the plain"\ 
    "New Kids On the Block is pretty much my favorite band."\ 
    "I like tacos")

dv="osascript -e \"set volume output volume ${desired_volume}\""
sv="osascript -e \"set volume output volume ${start_volume}\""
st="sleep $[ ($RANDOM % 10 ) + 1 ]s"

if [[ ${daemon} ]]; then
    while true; do
        #echo "Setting to my volume ${dv}"
        eval ${dv}
        st="sleep $[ ($RANDOM % 10 ) + 1 ]s";
        selected=${sayings[$RANDOM % ${#sayings[@]} ] }
        #echo "${selected}"
        say "${selected}"
        #echo "Setting to original volume ${sv}"
        eval ${sv}
        #echo ${st}
        eval ${st}
    done
else
    #echo "Setting to my volume ${dv}"
    eval ${dv}
    selected=${sayings[$RANDOM % ${#sayings[@]} ] }
    #echo "${selected}"
    say "${selected}"
    #echo "Setting to original volume ${sv}"
    eval ${sv}
fi


