#!/bin/bash
source components/common.sh

Print "install redis repos"
yum install  yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$LOG
stat $?

Print "enable redis repos"
yum-config-manager --enable remi &>>$LOG
stat $?

Print "install redis"
yum install redis -y &>>$LOG
stat $?

Print "update redis listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf  &>>$LOG
stat $?

Print "start redis"
systemctl enable redis &>>$LOG && systemctl start redis  &>>$LOG
stat $?