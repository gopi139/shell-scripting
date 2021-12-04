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


# redirectors(<,>) are used to give input directly to files
# > = standard output
# < = standard input
# >> = double append .. it gives the previous data as well as current data

# 1> used to output go to file(34-37 line) ; 2> used to error goto file(38-41 lines)
# &> used to output and error are go to same file (43-46 lines)

# [ centos@ip-172-31-81-229 ~/shell-scripting ]$ ls -ld /boot /boo1
# ls: cannot access /boo1: No such file or directory
# dr-xr-xr-x. 5 root root 4096 Nov 11 17:00 /boot
# [ centos@ip-172-31-81-229 ~/shell-scripting ]$ ls -ld /boot /boo1 1>/tmp/out
# ls: cannot access /boo1: No such file or directory
# [ centos@ip-172-31-81-229 ~/shell-scripting ]$ cat /tmp/out
# dr-xr-xr-x. 5 root root 4096 Nov 11 17:00 /boot
# [ centos@ip-172-31-81-229 ~/shell-scripting ]$ ls -ld /boot /boo1 2>/tmp/err
# dr-xr-xr-x. 5 root root 4096 Nov 11 17:00 /boot
# [ centos@ip-172-31-81-229 ~/shell-scripting ]$ cat /tmp/err
# ls: cannot access /boo1: No such file or directory
# [ centos@ip-172-31-81-229 ~/shell-scripting ]$ ls -ld /boot /boo1 &>/tmp/total
# [ centos@ip-172-31-81-229 ~/shell-scripting ]$ cat /tmp/total
# ls: cannot access /boo1: No such file or directory
# dr-xr-xr-x. 5 root root 4096 Nov 11 17:00 /boot
# [ centos@ip-172-31-81-229 ~/shell-scripting ]$

# show no output in screen we use &>/dev/null
# ex:[ centos@ip-172-31-81-229 ~/shell-scripting ]$ ls -ld /tmp /too &>/dev/null