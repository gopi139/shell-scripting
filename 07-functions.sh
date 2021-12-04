#!/bin/bash
# name assigned to set of commands is called function
# function are used to keep the code  DRY(Don't Repeat Yourself) i.e reusability
# function should be declared before using it

function abd(){
  echo iam function abd
  echo a in a function = $a
  echo 1st argument of function =$1
  b=20
}

xyz(){
  echo iam function xyz
}
#main program
a=10
abd
abd $1
echo b in main program =$b
xyz

echo 1st argument of main program =$1