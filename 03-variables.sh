#!/bin/bash
## name assigned to data is variable
## i.e var=data

## in shell no data types , shell consider everything as a string

a=100
b=abc

## to access data use $ before the variable name

echo value of a=$a
echo value of b=$b

echo vaie of a=${a}

x=20
y=25
echo $x*$y =500

## for getting dynamic data ; syntax: var=$(command)

DATE=$(date +%F)
echo welcome, today date is $DATE

## arthmatic expression ; syntax: var=$((expression)) ex: var=$((2+3-5))

x=$((2+3+6+6+7))
echo value of x is $x

echo COURSE NAME = $COURSE_NAME
