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
    echo "osdetect.sh"
    echo
    echo "Description:"
    echo "Distinguish between MS-Windows/Linux/MacOS"
    echo
    echo "Usage: bash osdetect.sh"
    echo "  output will be one of: Linux MSWin macOS"
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
