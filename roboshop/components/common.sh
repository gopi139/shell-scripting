#!/bin/bash
# -n gives the continue to next line
# ex:[ centos@ip-172-31-90-34 ~/shell-scripting/roboshop ]$ echo hello
     #hello
     #[ centos@ip-172-31-90-34 ~/shell-scripting/roboshop ]$ echo -n hello
     #hello[ centos@ip-172-31-90-34 ~/shell-scripting/roboshop ]$


Print(){
  echo -n -e "\e[1m$1\e[0m ......"
  echo -e "\n\e[36m============ $1 =============\e[0m" >>$LOG
}
stat (){
  if [ $1 -eq 0 ]; then
      echo -e "\e[1;32msuccess\e[0m"
  else
      echo -e "\e[1;31mfailure\e[0m"
      echo -e "\e[33mscript failed for detail log in $LOG file \e[0m"
      exit 1
  fi
}
LOG=/tmp/roboshop.log
rm -f $LOG

NODEJS() {
  Print "install nodejs"
  yum install nodejs make gcc-c++ -y &>>$LOG
  stat $?

  Print "add $COMPONENT_NAME roboshop"
  id roboshop &>>$LOG
  if [ $? -eq 0 ]; then
    echo "user roboshop already exists" &>>$LOG
  else
    useradd roboshop &>>$LOG
 fi
  stat $?

  Print "download $COMPONENT_NAME"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$LOG
  stat $?

  Print "remove old content"
  rm -rf /home/roboshop/${COMPONENT}
  stat $?

  Print "extract $COMPONENT_NAME"
  unzip -o -d /home/roboshop /tmp/${COMPONENT}.zip &>>$LOG
  stat $?

  Print "copy content"
  mv /home/roboshop/${COMPONENT}-main /home/roboshop/${COMPONENT} &>>$LOG
  stat $?

  Print "install nodejs dependencies"
  cd /home/roboshop/${COMPONENT}
  npm install --unsafe-perm &>>$LOG
  stat $?

  Print "fix app permissions"
  chown -R roboshop:roboshop /home/roboshop
  stat $?

  Print "update DNS record in systemd config"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/g' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' /home/roboshop/${COMPONENT}/systemd.service &>>$LOG
  stat $?

  Print "copy systemd file"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>$LOG
  stat $?

  Print "start $COMPONENT_NAME service"
  systemctl daemon-reload &>>$LOG && systemctl start ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
  stat $?


}