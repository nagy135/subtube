#!/bin/bash

EXECUTABLE_FOLDER=/usr/bin
INSTALL_DIR=/usr/local/share/subtube

if [[ $1 == '--remove' ]]; then
    rm $EXECUTABLE_FOLDER/subtube
    rm -rf $INSTALL_DIR
else

    mkdir $INSTALL_DIR
    mkdir $INSTALL_DIR/resources

    cp subtube $EXECUTABLE_FOLDER/subtube
    chmod +x $EXECUTABLE_FOLDER/subtube
    cp -r resources/* $INSTALL_DIR/resources
    chmod -R 777 $INSTALL_DIR/resources
fi
