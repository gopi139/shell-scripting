#!/bin/bash

source components/common.sh

COMPONENT_NAME=User
COMPONENT=user

NODEJS


Print "checking db connection from app"
STAT=$(curl -s localhost:8080/health | jq .mongo)
if [ $STAT == 'true' ]; then
   stat 0
else
   stat 1
fi
