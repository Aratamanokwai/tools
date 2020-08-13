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
    echo "fuzzer.sh"
    echo
    echo "Description:"
    echo "Fuzz a specified argument of a program."
    echo
    echo "Usage:"
    echo "bash $0 <executable> <arg1> [?] <arg3> ..."
    echo "  <executable> The executable program/script."
    echo "  <argn> The static arguments for the executable."
    echo "  '?' The argument to be fuzzed."
    echo "  example: $0 ./myprog -t '?' fn1 n2"
}

function usagexit()
{
    usage
    exit 64
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

if (($# < 2))
then
    usagexit
fi

# The app we will fuzz is the first arg.
THEAPP="$1"
shift
# Is it really there?
type -t "$THEAPP" >/dev/null || usagexit
## echo "THEAPP: $THEAPP"   3 For debug

# Which arg to vary?
# Find the ? and note its position.
declare -i i
for ((i=0; $#; i++))
do
    ALIST+=( "$1" )
    if [[ $1 == '?' ]]
    then
        NDX=$i
    fi
    shift
done
## echo "NDX: $NDX"    # For debug

## printf "Executable: %s  Arg: %d %s\n" $THEAPP $NDX "${ALIST[$NDX]}"  # For debug

# Now fuzz away:
#MAX=10000
MAX=55
FUZONE="a"
FUZARG=""
for ((i=1; i <= MAX; i++))
do
    FUZARG="${FUZARG}${FUZONE}" # aka +=
    ALIST[$NDX]="$FUZARG"
    # order of >s is important
    $THEAPP "${ALIST[@]}" 2>&1 > /dev/null
    if (( $? ))
    then
        echo "index: $i" >&2    # For debug
        echo "Caused by: $FUZARG" >&2
    fi
done
