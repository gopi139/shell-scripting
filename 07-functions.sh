#!/bin/bash
# name assigned to set of commands is called function
# function are used to keep the code  DRY(Don't Repeat Yourself) i.e reusability
# function should be declared before using it

function abd(){
  echo iam function abd
}

xyz(){
  echo iam function xyz
}
#main program
abd
xyz
