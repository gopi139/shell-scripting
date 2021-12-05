#!/bin/bash

read -p 'enter your name:' = username

if ["$username" == "root"]; then
     echo " you are a root user"
else
     echo "you are non root user"
