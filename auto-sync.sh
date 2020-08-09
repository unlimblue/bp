#!/bin/bash
while true
do
    curl -s localhost:4040/http/in | grep -oP 'tcp://server.natappfree.cc:(\d*)' > proxy
    new=$(git status | grep proxy | wc -l)
    if [ $new = 1 ]
    then
        git add proxy
        git commit -m "new proxy - $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    push=$(git log --decorate --oneline | head -n 1 | grep "origin/master" | wc -l)
    if [ $new = 0 ]
    then
        git push origin master
    else
        echo nothing to do
    fi
    sleep 3600
done
