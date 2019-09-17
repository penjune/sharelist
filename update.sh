#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# deps
if [ -n "$(command -v apt-get)" ]
then
  apt-get install -y wget unzip >/dev/null 2>&1
elif [ -n "$(command -v yum)" ]
then
  yum install -y wget unzip >/dev/null 2>&1
fi

wget -O sharelist-master.zip https://github.com/penjune/sharelist/archive/master.zip >/dev/null 2>&1

unzip -q -o sharelist-master.zip -d ./

cp -rf sharelist-master/* ./
rm -rf sharelist-master*

npm install >/dev/null 2>&1
pm2 restart all >/dev/null 2>&1
