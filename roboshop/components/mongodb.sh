#!/bin/bash
source components/common.sh

COMPONENT_NAME=mongoDB
COMPONENT=mongodb

Print "download repo file "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG
stat $?
Print "installing mongoDB"
yum install -y mongodb-org &>>$LOG
stat $?

Print "update mongoDB config file"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>>$LOG
stat $?

Print "enabling mongoDB"
systemctl enable mongod &>>$LOG
stat $?

Print "starting mongoDB"
systemctl restart mongod &>>$LOG
stat $?

DOWNLOAD "/tmp"

Print "load schema"
cd /tmp/mongodb-main
mongo < catalogue.js &>>$LOG && mongo < users.js &>>$LOG
stat $?