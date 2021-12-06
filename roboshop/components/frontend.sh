#!/bin/bash
source components/common.sh

Print "installing nginx"
yum install nginx -y &>>$LOG
stat $?


Print "download HTML pages"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
stat $?

Print "remove old html pages"
rm -rf  /usr/share/nginx/html/* &>>$LOG
stat $?

Print "extract frontend archive"
unzip -o -d /tmp /tmp/frontend.zip &>>$LOG
stat $?

Print "copying files to nginx path"
mv /tmp/frontend-main/static/*  /usr/share/nginx/html/.  &>>$LOG
stat $?

Print "copy nginx roboshop config file"
cp /tmp/frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf  &>>$LOG
stat $?


Print "enabling the nginx"
systemctl enable nginx &>>$LOG
stat $?

Print "starting the nginx"
systemctl restart nginx &>>$LOG
stat $?