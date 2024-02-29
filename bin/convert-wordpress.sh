#!/bin/bash

mkdir floppyroot
# cp autounattend.xml floppyroot/

# 731k limit
# Notes on options: https://madlabber.wordpress.com/2019/06/13/how-to-create-floppy-disk-images-on-macos/
hdiutil create -size 1440k -fs "MS-DOS FAT12" -layout NONE -srcfolder floppyroot -format UDRW -ov floppy.dmg
