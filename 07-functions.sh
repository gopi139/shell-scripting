#!/bin/bash
# name assigned to set of commands is called function
# function are used to keep the code  DRY(Don't Repeat Yourself) i.e reusability
# function should be declared before using it

function abd(){
  echo iam function abd
  echo a in a function = $a
  b=20
}

xyz(){
  echo iam function xyz
}
#main program
a=10
abd
echo b in main program =$b
xyz