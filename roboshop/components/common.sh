#!/bin/bash
# -n gives the continue to next line
# ex:[ centos@ip-172-31-90-34 ~/shell-scripting/roboshop ]$ echo hello
     #hello
     #[ centos@ip-172-31-90-34 ~/shell-scripting/roboshop ]$ echo -n hello
     #hello[ centos@ip-172-31-90-34 ~/shell-scripting/roboshop ]$


Print(){
  echo -n -e "\e[1m$1\e[0m ......"
  echo -e "\n\e[36m============ $1 =============\e[0m" >>$LOG
}
stat (){
  if [ $1 -eq 0 ]; then
      echo -e "\e[1;32msuccess\e[0m"
  else
      echo -e "\e[1;31mfailure\e[0m"
      echo -e "\e[33mscript failed for detail log in $LOG file \e[0m"
      exit 1
  fi
}
LOG=/tmp/roboshop.log
rm -f $LOG