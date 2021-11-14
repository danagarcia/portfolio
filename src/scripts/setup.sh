#!/bin/bash -x
echo '################### webserver userdata begins #####################'
touch ~opc/userdata.`date +%s`.start

echo '########## node.js installation ##########'
sudo yum install -y oracle-nodejs-release-el7 oracle-release-el7
sudo yum install -y nodejs

echo '########## node.js project installation ##########'
sudo yum install -y git
mkdir ~/repos && cd ~/repos
git clone https://github.com/danagarcia/portfolio.git
cd ./portfolio/src/portfolio

echo '########## configure firewall ##########'
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

echo '########## set project to start on startup ##########'
sudo echo "npm start $pwd/server.js" >> /etc/rc.local

echo '########## reboot server ##########'
sudo shutdown -r now

touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'