#!/bin/bash
sudo apt update
sudo apt install nginx unzip -y
cd /tmp && wget https://www.free-css.com/assets/files/free-css-templates/download/page295/kider.zip
unzip /tmp/kider.zip
sudo mv /tmp/preschool-website-template /var/www/html/preschool
#aws cloudwatch set-alarm-state --alarm-name cpuutilisationTG --state-value ALARM --state-reason "test"
#sudo stress -c 12 --timeout 240s