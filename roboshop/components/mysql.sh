#!/bin/bash

source components/common.sh

COMPONENT_NAME=MySQL
COMPONENT=mysql

Print "setup MySQL repo"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>$LOG
stat $?

Print "install mariadb service"
yum remove mariadb-libs -y &>>$LOG && yum install mysql-community-server -y &>>$LOG
stat  $?
Print "Start MySQL Service"
systemctl enable mysqld &>>$LOG && systemctl start mysqld &>>$LOG
stat $?

DEFAULT_PASSWORD=$(sudo grep 'temporary password' /var/log/mysqld.log |awk '{print $NF}')
NEW_PASSWORD=RoboShop@1

echo 'show databases;' | mysql -uroot -p"${NEW_PASSWORD}" &>>$LOG
if [ $? -ne 0 ]; then
  Print "changing the default password"
  echo -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${NEW_PASSWORD}';\nuninstall plugin validate_password;" >/tmp/pass.sql
  mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" </tmp/pass.sql &>>$LOG
  stat $?
fi

DOWNLOAD

 ## cd /tmp
 ## unzip mysql.zip
 ## cd mysql-main
 ## mysql -u root -pRoboShop@1 <shipping.sql