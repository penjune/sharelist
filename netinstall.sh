#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# deps
if [ -n "$(command -v apt-get)" ]
then
  apt-get install -y curl wget unzip >/dev/null 2>&1
  curl -sL https://deb.nodesource.com/setup_8.x | bash - >/dev/null 2>&1
  apt-get install -y nodejs >/dev/null 2>&1
elif [ -n "$(command -v yum)" ]
then
  yum install -y curl wget unzip >/dev/null 2>&1
  curl --silent --location https://rpm.nodesource.com/setup_8.x | bash - >/dev/null 2>&1
  yum install -y nodejs >/dev/null 2>&1
fi

wget -O sharelist-master.zip https://github.com/penjune/sharelist/archive/master.zip >/dev/null 2>&1

unzip -q -o sharelist-master.zip -d ./

mv sharelist-master sharelist
rm -f sharelist-master.zip

cd sharelist
npm install >/dev/null 2>&1
npm install pm2 -g >/dev/null 2>&1

pm2 start app.js >/dev/null 2>&1
pm2 save >/dev/null 2>&1
pm2 startup >/dev/null 2>&1
