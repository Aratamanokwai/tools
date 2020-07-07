#!/bin/bash -
#
# Cybersecurity Ops with bash
#
# For debug
set -C  # リダイレクトで既存の電子書籍を上書きしない。
set -e  # パイプや副次甲殻で實行した命令が一つでも不具合になつたら直ちに甲殻を終了する。

function usage()
{
    echo "typesearch.sh"
    echo
    echo "Description:"
    echo "Search the file system for a given file type."
    echo "It print out thepathname when founf."
    echo
    echo "Usage:"
    echo "typesearch.sh [-c dir] [-i] [-R|r] <pattern> <path>"
    echo "  -c Copy files found to dir."
    echo "  -i Ignore case."
    echo "  -R|r Recursively search subdirectories."
    echo "  <pattern> File type pattern to search for."
    echo "  <path> Path to start search."
}

# PARSE option argments:
while getopts 'c:hirR' opt; do
  case "${opt}" in
    c) # Copy found files to specified directoty.
        COPY=YES
        DESTDIR="$OPTARG"
        ;;
    i) # Ignore u/l case differences in search.
        CASEMATCH='-i'
        ;;
    [Rr]) # Recursive.
        unset DEEPORNOT
        ;;
    h) # help
        usage
        exit 0
        ;;
    *) # Unkown/Unsupported option.
       # Error mesg will come from getopts, so just exit.
        exit 64
        ;;
  esac
done
shift $((OPTIND - 1))

PATTERN=${1:-PDF document}
STARTDIR=${2:-.}
find $STARTDIR $DEEPORNOT -type f | while read FN
do
    file $FN | egrep -q $CASEPATH "$PATTERN"
    if (( $? == 0 ))    # found one
    then
        echo $FN
        if [[ $COPY ]]
        then
            cp -p $FN $DESTDIR
        fi
    fi
done
