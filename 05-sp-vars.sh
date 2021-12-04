#!/bin/bash
# $0-$n ,$*,$#,$@ are special varibles  lies inside shell
# $0==script name
# $1-$n == argument names

echo 0=$0
echo 1=$1
echo 2=$2

# $*,$@ are gives total arguments
echo "*"=$*
echo "@"=$@

# $# gives no of arguments in shell
echo "#"=$#

echo -e "your name:$1\nyour age:$2"

# quotes ("" or '') are used for print what exatly you want
# ex: echo "a"----> output: a
#     echo a -----> output: gives some number like 10,20...etc

