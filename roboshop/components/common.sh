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

DOWNLOAD(){
  Print "download $COMPONENT_NAME"
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip" &>>$LOG
  stat $?

  Print "extract $COMPONENT_NAME content"
  unzip -o -d $1 /tmp/${COMPONENT}.zip &>>$LOG
  stat $?

  if [ "$1" == "/home/roboshop" ]; then
    Print "remove old content"
    rm -rf /home/roboshop/${COMPONENT}
    stat $?

    Print "copy content"
    mv /home/roboshop/${COMPONENT}-main /home/roboshop/${COMPONENT}
    stat $?
  fi
}

ROBOSHOP_USER(){
  Print "add  roboshop user"
  id roboshop &>>$LOG
  if [ $? -eq 0 ]; then
      echo "user roboshop already exists" &>>$LOG
  else
      useradd roboshop &>>$LOG
  fi
  stat $?
}

SYSTEMD() {
  Print "fix app permissions"
  chown -R roboshop:roboshop /home/roboshop
  stat $?

  Print "update DNS record in systemD config"
  sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/g' -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/g' -e 's/CARTENDPOINT/cart.roboshop.internal/' -e 's/DBHOST/mysql.roboshop.internal/' -e 's/USERHOST/user.roboshop.internal/g' -e 's/AMQPHOST/rabbitmq.roboshop.internal/g'  /home/roboshop/${COMPONENT}/systemd.service &>>$LOG
  stat $?

  Print "copy systemD  file"
  mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>$LOG
  stat $?

  Print "start $COMPONENT_NAME service"
  systemctl daemon-reload &>>$LOG && systemctl start ${COMPONENT} &>>$LOG && systemctl enable ${COMPONENT} &>>$LOG
  stat $?
}

PYTHON() {
  Print "Install Python 3"
  yum install python36 gcc python3-devel -y &>>$LOG
  stat $?

  ROBOSHOP_USER

  DOWNLOAD "/home/roboshop"

  Print "Install the dependencies"
  cd /home/roboshop/${COMPONENT}
  pip3 install -r requirements.txt &>>$LOG
  stat $?
  USER_ID=$(id -u roboshop)
  GROUP_ID=$(id -g roboshop)

  Print "update ${COMPONENT_NAME} service"
  sed -i -e "/uid/ c uid =${USER_ID}" -e "/gid/ c gid =${GROUP_ID}" /home/roboshop/${COMPONENT}/${COMPONENT}.ini &>>$LOG
  stat $?

  SYSTEMD
}


MAVEN(){
  Print "install maven"
  yum install maven -y &>>$LOG
  stat $?

  ROBOSHOP_USER

  DOWNLOAD "/home/roboshop"

  Print "make maven package"
  cd /home/roboshop/${COMPONENT}
  mvn clean package &>>$LOG && mv target/shipping-1.0.jar shipping.jar &>>$LOG
  stat $?

  SYSTEMD
}

NODEJS() {
  Print "install nodejs"
  yum install nodejs make gcc-c++ -y &>>$LOG
  stat $?

  ROBOSHOP_USER

  DOWNLOAD "/home/roboshop"

  Print "install nodejs dependencies"
  cd /home/roboshop/${COMPONENT}
  npm install --unsafe-perm &>>$LOG
  stat $?

  SYSTEMD

}

CHECK_MONGO_FROM_APP() {
  Print "checking db connection from app"
  STAT=$(curl -s localhost:8080/health | jq .mongo)
  if [ "$STAT" == "true" ]; then
    stat 0
  else
    stat 1
  fi

}

CHECK_REDIS_FROM_APP() {
  Print "checking db connection from app"
  STAT=$(curl -s localhost:8080/health | jq .redis)
  if [ "$STAT" == "true" ]; then
    stat 0
  else
    stat 1
  fi

}