#!/bin/bash
# $0-$n ,$*,$#,$@ are special varibles  lies inside shell

echo 0=$0
echo 1=$1
echo 2=$2

echo "*"=$*
echo "@"=$@
echo "#"=$#

echo -e "your name:$1\nyour age:$2"

