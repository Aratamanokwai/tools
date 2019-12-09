# coding: utf-8
# vim: fileencoding=utf-8 ff=dos
#
# py36以上
#
# 変更履歴：
# Version. 0.00: 雛形
# Version. 1.00: 初版
"""雛形
"""

# 電子書類の情報
__version__ = 'Ver: 0.00'
__prog__ = 'temp.py'
__description__ = '説明'

import sys
from sys import exit
from sys import stdin
from sys import stdout
from sys import stderr
import os
import argparse

# 以下は自作書庫

_vb = False

EX_OK = 0
EX_NG = 1
EX_USAGE = 64


## 以下に自作符號


if '__main__' == __name__:

    # パーサーを作る
    parser = argparse.ArgumentParser(
            prog='temp.py', # プログラム名
            description=__description__, # 引数のヘルプの前に表示
            epilog='Python 3.6以上', # 引数のヘルプの後で表示
            add_help=True, # -h/–help オプションの追加
            )
    parser.add_argument('--test', '-t', action='store_true' )
    parser.add_argument('--version', '-V', action='store_true' )
    parser.add_argument('--verbose', '-v', action='store_true' )

    # 引数を解析する
    args = parser.parse_args()
    if args.version:

        print(f'{__version__:s}')
        exit(EX_OK)
    if args.verbose:

        _vb = True
    if args.test:

        import doctest
        doctest.testmod(verbose=_vb)
        exit(EX_OK)

    (_vb and print('[*] temp.py'))
