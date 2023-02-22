#!/bin/bash

## Get sudo permissions
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi


USING_SOURCE=0

## Ask for folder name
echo 'What should the package folder be called?'
read -p 'Folder: ' FOLDER_NAME

## Ask if installing using source or dpkg
read -p 'Do you want to use source? Default is using dpkg (y/N) ' yN
case $yN in
	[yY] )  echo "Using source"
		USING_SOURCE=1
		;;
	[nN] )  echo "Using dpkg"
		;;
	*    )  echo "Using dpkg" 
		;;
esac	

## Ask for link to package file
echo 'Please enter the link to the package download: '
read -p 'Link: ' LINK
BASENAME=$(basename $LINK)

## Create directory in /usr/local/src
FOLDER_PATH=/usr/local/src/$FOLDER_NAME
umask 000

chmod +w /usr/local/src
mkdir $FOLDER_PATH

## Download package using Link
wget $LINK -P $FOLDER_PATH


## Report if the installation was Succesfull


## if Unsuccesfull check why, and install any missing dependencies then retry the package install




