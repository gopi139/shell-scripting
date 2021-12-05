#!/bin/bash

read -p 'enter your name:' username
if [ "$username" == "root" ]; then
    echo "you are a root user"
else
    echo "you are a non root user"
fi

if [ $UID -eq 0 ]; then
    echo "you are a root user"
else
    echo "you are non root user"
fi