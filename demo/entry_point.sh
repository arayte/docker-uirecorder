#!bin/bash
nohup /opt/bin/entry_point.sh &
sleep 10
npm install
npm run moduletest baidu_search 
