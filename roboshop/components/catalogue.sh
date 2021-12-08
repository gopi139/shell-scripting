#!/bin/bash

# mspace=$(cat $0 | grep ^Print | awk -F '"' '{print $2}' | awk '{print length}' | sort | tail -1)

source components/common.sh

COMPONENT_NAME=Catalogue
COMPONENT=catalogue

NODEJS

CHECK_MONGO_FROM_APP