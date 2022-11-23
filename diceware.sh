#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

DEFAULT_DICTIONARY="eff"
DEFAULT_STRENGTH="5"

# Set defaults:
dictionary=$DEFAULT_DICTIONARY
strength=$DEFAULT_STRENGTH

usage() {
    echo -e "Diceware password generation tool, version: v1"
    echo "Usage: $0 [-s 5..] [-d en|eff|alt]"
    exit 1
}

while getopts ":s:d:" o; do
    case "${o}" in
        s)
            strength=${OPTARG}
            ((strength >= 5)) || usage
            ;;
        d)
            dictionary=${OPTARG}
            [[ "$dictionary" != "en" ]] && \
		    [[ "$dictionary" != "eff" ]] && \
		    [[ "$dictionary" != "alt" ]] && \
		    usage
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

# Load dictionary:
if [[ "$dictionary" == "eff" ]]; then
    datafile="${SCRIPT_DIR}/diceware_data/eff_large.data"
elif [[ "$dictionary" == "en" ]]; then
    datafile="${SCRIPT_DIR}/diceware_data/simple.data"
elif [[ "$dictionary" == "alt" ]]; then
    datafile="${SCRIPT_DIR}/diceware_data/alternate.data"
fi

# Generate password:
password_raw=$(shuf -n $strength "$datafile")
#echo "*****************"
echo $password_raw
#echo "*****************" 
