#!/bin/bash
while true
do
    curl -s localhost:4040/http/in | grep -oP 'tcp://server.natappfree.cc:(\d*)' > proxy
    new=$(git status | grep proxy | wc -l)
    echo $new
    if [ $new = 1 ]
    then
        git add proxy
        git commit -m "new proxy"
    fi
    git push origin master
    sleep 5
done
