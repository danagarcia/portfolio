#!/bin/bash -x
while getopts u:d: flag
do
    case "${flag}" in
        u) project_uri=${OPTARG};;
        d) project_dir=${OPTARG};;
    esac
done

echo '################### webserver userdata begins #####################'
touch ~opc/userdata.`date +%s`.start

echo '########## node.js installation ##########'
yum install -y oracle-nodejs-release-el7 oracle-release-el7
yum install -y nodejs

echo '########## node.js project installation ##########'
yum install -y git
mkdir ~/repos && cd ~/repos
git clone "$project_uri"
cd $project_dir
npm start

echo '########## configure firewall ##########'
firewall-offline-cmd --add-service=http
systemctl enable firewalld
systemctl restart firewalld

echo '########## set project to start on startup ##########'
echo "npm start $pwd/server.js" >> /etc/rc.local

touch ~opc/userdata.`date +%s`.finish
echo '################### webserver userdata ends #######################'