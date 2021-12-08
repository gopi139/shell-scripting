#!/bin/bash

# mspace=$(cat $0 | grep ^Print | awk -F '"' '{print $2}' | awk '{print length}' | sort | tail -1)

source components/common.sh

COMPONENT_NAME=Catalogue
COMPONENT=catalogue

NODEJS

Print "checking db connection from app"
STAT=$(curl -s localhost:8080/health | jq .mongo)
if [ $STAT == 'true' ]; then
   stat 0
else
   stat 1
fi
