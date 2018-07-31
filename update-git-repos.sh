#!/bin/bash

function update_repos(){
        CAMINHO=$1;

        for i in `/usr/bin/ls $CAMINHO`; do
                DIR=$CAMINHO/$i;
                if [ -d "$DIR" ]; then
                        echo $DIR;
                        cd $DIR;
                        if [ -d "$DIR/.git" ]; then
                                BRANCH=`/usr/bin/git rev-parse --abbrev-ref HEAD`
                                /usr/bin/git pull origin $BRANCH
                        fi
                        if [ -d "$DIR/.svn" ]; then
                                /usr/bin/svn update
                        fi
                        echo
                fi

                cd 

        done
}

update_repos /my/home/dir/project1;
update_repos /my/home/dir/project2;
