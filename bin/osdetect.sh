#!/bin/bash -
#
# Cybersecurity Ops with bash
# osdetect.sh
#
# Description:
# Distinguish between MS-Windows/Linux/MacOS

function usage()
{
    echo "Usage: bash osdetect.sh"
    echo "  output will be one of: Linux MSWin macOS"
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

if type -t wevtutil &> /dev/null
then
    OS=MSWin
elif type -t scutil &> /dev/null
then
    OS=MacOS
else
    OS=Linux
fi

echo $OS
