#!/bin/bash
source components/common.sh

Print "installing nginx"
yum install nginx -y &>>$LOG
stat $?

Print "enabling the nginx"
systemctl enable nginx
stat $?

Print "starting the nginx"
systemctl start nginx
stat $?

exit

Print "download HTML pages"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$LOG
stat $?

#Print "remove old html pages"
#rm -rf  /usr/share/nginx/html/* &>>$LOG
#stat $?

#unzip /tmp/frontend.zip
#mv frontend-main/* .
#mv static/* .
#rm -rf frontend-master static README.md
#mv localhost.conf /etc/nginx/default.d/roboshop.conf
#systemctl restart nginx