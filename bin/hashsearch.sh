#!/bin/bash -
#
# Cybersecurity Ops with bash
#
# For debug
set -u  # 變數展開中に、設定してゐない変数があつたら不具合とする（特殊パラメーターである「@」と「*」は除く）
set -C  # リダイレクトで既存の電子書籍を上書きしない。
set -e  # パイプや副次甲殻で實行した命令が一つでも不具合になつたら直ちに甲殻を終了する。

function usage()
{
    echo "hashsearch.sh"
    echo
    echo "Description:"
    echo "Recursively search a given directory for a file that"
    echo "matches a given SHA-1 hash."
    echo
    echo "Usage: hashsearch.sh <hash> <directory>"
    echo "  hash - SHA-1 hash value to file to find."
    echo "  sirectory - Top directory to start search."
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

HASH=$1
DIR=${2:-.}     # default is here, cwd

# echo "HASH: $HASH"
# echo "DIR: $DIR"

# Convert pathname into an absolute path.
function mkabspath()
{
    if [[ $1 == /* ]]; then
        ABS=$1
    else
        ABS="$PWD/$1"
    fi
}

find $DIR -type f |
while read fn
do
    THISONE=$(sha1sum "$fn")
    THISONE=${THISONE%% *}
    # echo "THISONE: $THISONE"
    # echo "fn: $fn"
    if [[ $THISONE == $HASH ]]; then
        mkabspath "$fn"
        echo $ABS
    fi
done
