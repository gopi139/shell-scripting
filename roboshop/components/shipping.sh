#!/bin/bash

source components/common.sh

COMPONENT_NAME=Shipping
COMPONENT=shipping

MAVEN

Print "checking DB connections from app"
sleep 15
STAT=$(curl -s http://localhost:8080/health)
if [ "$STAT" == "OK" ]; then
  stat 0
else
  stat 1
fi
