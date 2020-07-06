#!/bin/bash -
#
# Cybersecurity Ops with bash
# getlocal.sh
#
# Description:
# Gathers general system information and dumps it to a file.
#

function usage()
{
    echo "Usage: bash getlocal.sh < cmds.txt"
    echo "  cmds.txt is a file with list of commands to run."
}

# PARSE option argments:
while getopts 'h' opt; do
  case "${opt}" in
    h) # help
        usage
        exit 0 ;;
  esac
done
shift $((OPTIND - 1))
# SepCmds - Separate the commands from the line of input
function SepCmds()
{
    LCMD=${ALINE%%|*}
    REST=${ALINE#*|}
    MCMD=${REST%%|*}
    REST=${REST#*|}
    TAG=${REST%%|*}

    if [[ $OSTYPE == "MSWin" ]]
    then
        CMD="$MCMD"
    else
        CMD="$LCMD"
    fi
}

function DumpInfo()
{
    printf '<systeminfo host="%s" type="%s"' "$HOSTNM" "$OSTYPE"
    printf ' date="%s" time="%s">\n' "$(date '+%F')" "$(date '+%T')"
    readarray CMDS
    for ALINE in "${CMDS[@]}"
    do
        # Ignore comments.
        if [[ ${ALINE:0:1} == '#' ]] ; then continue ; fi

        SepCmds

        if [[ ${CMD:0:3} == N/A ]]
        then
            continue
        else
            printf "<%s>\n" $TAG
            $CMD
            printf "</%s>\n" $TAG
        fi
    done

    printf "</systeminfo>\n"
}

OSTYPE=$(osdetect.sh)
# echo $OSTYPE
HOSTNM=$(hostname)
# echo $HOSTNM
TMPFILE="${HOSTNM}.info"
# echo $TMPFILE

# Gather the info into the tmp file; errors, too.
DumpInfo > $TMPFILE 2>&1