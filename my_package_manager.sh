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
mkdir "$FOLDER_PATH"
cd "$FOLDER_PATH/.."

## Download package using Link
wget $LINK -P "$FOLDER_PATH/.."


## Unpack / Compile
if [ $USING_SOURCE -eq 0 ]; then
	# Use DPKG
	mv $BASENAME "$FOLDER_PATH"
	sudo dpkg -i "$FOLDER_PATH/$BASENAME" 
	sudo apt -f install
else
	# Source
	pwd
	sudo tar -xf $BASENAME -C $FOLDER_PATH --strip-components 1
	cd "$FOLDER_PATH"
	pwd
	./configure
	sudo make
	sudo make install

fi

## Report if the installation was Succesfull


## if Unsuccesfull check why, and install any missing dependencies then retry the package install




