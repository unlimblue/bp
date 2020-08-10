#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Workdir="${DIR}
cd $DIR
while true
do
    curl -s localhost:4040/http/in | grep -oP 'tcp://server.natappfree.cc:(\d*)' > proxy
    new=$(git status | grep proxy | wc -l)
    if [ $new -gt 0 ]
    then
        git add proxy
        git commit -m "new proxy - $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    push=$(git log --decorate --oneline | head -n 1 | grep "origin/master" | wc -l)
    if [ $push = 0 ]
    then
        git push origin master
    else
        echo nothing to do
    fi
    sleep 60
done
