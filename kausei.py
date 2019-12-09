# coding: utf-8
# vim: fileencoding=utf-8 ff=dos
#
# py36以上
#
# 変更履歴：
# Version. 0.00: 雛形
# Version. 0.01: 骨組
# Version. 1.00: 初版
"""校正道具

>>> import kausei
"""

# 電子書類の情報
__version__ = 'Ver: 0.01'
__prog__ = 'kausei.py'
__description__ = '文章を校正します。'

import sys
from sys import exit
from sys import stdin
from sys import stdout
from sys import stderr
import os
import argparse

_vb = False

EX_OK = 0
EX_NG = 1
EX_USAGE = 64

## 以下に自作符號


if '__main__' == __name__:

    # パーサーを作る
    parser = argparse.ArgumentParser(
            prog='kausei.py',
            description=__description__,
            epilog='新字新假名は原則的に正字正假名遣に變換します。',
            add_help=True,
            )
    parser.add_argument('--file', '-f',
            help='原稿諸類(.txt)',
            default='genkau.txt',
            )
    parser.add_argument('--sed', '-s',
            help='sed臺本の書類名(.sed)',
            default='henkwan.txt',
            )
    parser.add_argument('--output', '-o',
            help='出力書類名',
            default='output.txt',
            )
    parser.add_argument('--test', '-t', action='store_true' )
    parser.add_argument('--version', '-V', action='store_true' )
    parser.add_argument('--verbose', '-v', action='store_true' )

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

    (_vb and print('[*] kausei.py'))
    (_vb and print(f'{args}'))
