#!/bin/bash -
#
# Cybersecurity Ops with bash
#
# For debug
set -u  # 變數展開中に、設定してゐない変数があつたら不具合とする（特殊パラメーターである「@」と「*」は除く）
set -C  # リダイレクトで既存の電子書籍を上書きしない。
#set -e  # パイプや副次甲殻で實行した命令が一つでも不具合になつたら直ちに甲殻を終了する。

function usage()
{
    echo "scan.sh"
    echo
    echo "Description:"
    echo "Perform a port scan of a specified host."
    echo
    echo "Usage: scan.sh <output file>"
    echo "  <output file> File to save results in."
}

# PARSE option argments:
while getopts 'h' opt; do
  case "${opt}" in
    h) # help
        usage
        exit 0 ;;
    *) # Unkown/Unsupported option.
       # Error mesg will come from getopts, so just exit.
        exit 64
        ;;
  esac
done
shift $((OPTIND - 1))

function scan ()
{
    host=$1
    printf '%s' "$host"
    for ((port=1;port<1024;port++))
    do
        # Order f redirects is important for 2 reasons.
        echo >/dev/null 2>&1 < /dev/tcp/${host}/${port}
        if (($? == 0)) ; then printf ' %d' "${port}" ; fi
    done

    echo # or printf '\n'
}

#
# main loop
#   read in each host name (from stdin)
#    and scan for open ports
#   save the results in a file
#   whose name is supplied as an argument
#    or default to one based on today's date
#
printf -v TODAY 'scan_%(%F)T' -1    # e.g., scan_2017-11-27
OUTFILE=${1:-$TODAY}

#while read HOSTNAME
#do
#    scan $HOSTNAME
#done > $OUTFILE
scan localhost
