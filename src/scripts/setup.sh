#!/bin/bash -x
echo '################### webserver userdata begins #####################'
touch ~opc/userdata.`date +%s`.start

echo '########## node.js installation ##########'
yum install -y oracle-nodejs-release-el7 oracle-release-el7
yum install -y nodejs

echo '########## node.js project installation ##########'
yum install -y git
mkdir ~/repos && cd ~/repos
git clone https://github.com/danagarcia/portfolio.git
cd ./portfolio/src/portfolio
npm start

echo '########## configure firewall ##########'
firewall-offline-cmd --add-service=http
systemctl enable firewalld
systemctl restart firewalld

echo '########## set project to start on startup ##########'
echo "npm start $pwd/server.js" >> /etc/rc.local

touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'