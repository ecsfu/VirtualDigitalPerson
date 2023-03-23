#!/bin/bash
#export MAIN_ROOT=`realpath ${PWD}/../../../../`
#
#export PATH=${MAIN_ROOT}:${MAIN_ROOT}/utils:${PATH}
export LC_ALL=C  #使用C语言环境，即英文和ASCII编码


export PYTHONIOENCODING=UTF-8
export PYTHONDONTWRITEBYTECODE=1
#Python的环境变量设置，用于阻止Python在导入模块时生成.pyc文件。这样可以节省磁盘空间，提高加载速度，以及避免一些版本冲突的问题。
# Use UTF-8 in Python to avoid UnicodeDecodeError when LC_ALL=C

#export PYTHONPATH=${MAIN_ROOT}:${PYTHONPATH}

#MODEL=fastspeech2
#export BIN_DIR=${MAIN_ROOT}/paddlespeech/t2s/exps/${MODEL}
