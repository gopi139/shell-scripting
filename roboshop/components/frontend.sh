#!/bin/bash

Print(){
  echo -e "\e[1m$1\e[0m"
  echo -e "\n\e[36m============ $1 =============\e[0m" >>$LOG
}
LOG=/tmp/roboshop.log
rm -f $LOG
Print "installing nginx"
yum install nginx -y &>>$LOG
Print "enabling the nginx"
systemctl enable nginx
Print "starting the nginx"
systemctl start nginx
exit

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-master static README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
systemctl restart nginx