#!/bin/bash
# name assigned to set of commands is called function
# function are used to keep the code  DRY(Don't Repeat Yourself) i.e reusability
# function should be declared before using it

function abd(){
  echo iam function abd
  echo a in a function = $a
}

xyz(){
  echo iam function xyz
}
#main program
abd
a=10
xyz