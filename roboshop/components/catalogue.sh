#!/bin/bash

cat $0 | grep ^Print | awk '{Print $2}'
exit

source components/common.sh

Print "install nodejs"
yum install nodejs make gcc-c++ -y &>>$LOG
stat $?

Print "add user roboshop"
id roboshop &>>$LOG
if [ $? -eq 0 ]; then
  echo "user roboshop already exists" &>>$LOG
else
  useradd roboshop &>>$LOG
fi
stat $?

Print "download catalogue"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
stat $?

Print "remove old catalogue"
rm -rf /home/roboshop/catalogue
stat $?

Print "extract catalogue"
unzip -o -d /home/roboshop /tmp/catalogue.zip &>>$LOG
stat $?

Print "copy content"
mv /home/roboshop/catalogue-main /home/roboshop/catalogue &>>$LOG
stat $?

Print "install nodejs dependencies"
cd /home/roboshop/catalogue
npm install --unsafe-perm &>>$LOG
stat $?

Print "fix app permissions"
chown -R roboshop:roboshop /home/roboshop
stat $?

Print "update DNS record in systemd config"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/g'  /home/roboshop/catalogue/systemd.service &>>$LOG
stat $?

Print "copy systemd file"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$LOG
stat $?

Print "start catalogue service"
systemctl daemon-reload && systemctl start catalogue && systemctl enable catalogue &>>$LOG
stat $?

Print "checking db connection from app"
STAT=$(curl -s localhost:8080/health | jq .mongo)
if [ $STAT == 'true' ]; then
   stat 0
else
   stat 1
fi
