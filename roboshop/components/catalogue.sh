#!/bin/bash

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
npm install --unsafe--perm &>>$LOG
stat $?

Print "fix app permissions"
chown -R roboshop:roboshop /home/roboshop
stat $?

#NOTE: We need to update the IP address of MONGODB Server in systemd.service file
#Now, lets set up the service with systemctl.

# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue