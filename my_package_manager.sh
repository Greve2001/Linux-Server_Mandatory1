#!/bin/bash

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

echo $BASENAME
