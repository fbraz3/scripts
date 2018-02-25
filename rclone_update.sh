#!/bin/bash

INSTALL_DIR="/usr/local/install"
RCLONE_DIR="$INSTALL_DIR/rclone"
RCLONE_EXE="/usr/sbin/rclone"

mkdir -p $RCLONE_DIR;
cd $RCLONE_DIR

wget https://downloads.rclone.org/rclone-current-linux-amd64.zip -O rclone.zip;

RCLONE_FILE=` unzip -l rclone.zip |egrep "rclone$" |awk '{print $NF}'`;
if [ ! -z "$RCLONE_FILE" ]; then
    unzip -o rclone.zip;
    cp -f $RCLONE_FILE $RCLONE_EXE;
    chmod a+x $RCLONE_EXE
fi

cd $INSTALL_DIR
rm -rf $RCLONE_DIR
