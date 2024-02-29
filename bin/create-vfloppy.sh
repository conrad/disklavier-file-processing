#!/bin/bash
################################################################################
#
# Automated creation of virtual floppy disk with data
#
# Usage with default config:
# * Copy your data to a folder called 'input'
# * run the script: $ ./create-virtual-floppy.sh
# * The virtual floppy disk with data can be found timestamped in a 'output' folder
#
# Example use case: Windows automation of unattended installs via floppy disk existence of a 'Autounattend.xml' file
# * As a more manual but simpler way than found here: https://github.com/mwrock/packer-templates
#     * Using plain virtual-box + windows iso + floppy unattended config
#
# Code from
# * https://gist.github.com/iamsortiz/1bdb9774832ea65855b2dc1b9b4ee8dc
# * http://superuser.com/questions/342433/how-to-create-an-empty-floppy-image-with-virtualbox-windows-guest
#     * attribution creator: http://superuser.com/users/1686/grawity
#     * attribution editor: http://superuser.com/users/194694/gronostaj
################################################################################

################################################################################
#
# CONFIFURATION + INITILIZATION
#
################################################################################
INPUT_PATH='input'
OUTPUT_PATH='output'
VFLOPPY_NAME='vfloppy'
VFLOPPY_EXTENSION='vfd'
VFLOPPY_FILENAME=$VFLOPPY_NAME.$VFLOPPY_EXTENSION

# Using ___ at $var name to avoid name collision: given that at the end its gona "rm -rf" the path inside that $var
# Using $RANDOM at folder name to avoid name collision: given that at the end its gona "rm -rf" the path inside that $var
___WORKSPACE_PATH___="tmp-$RANDOM"

VFLOPPY_FILE_PATH=$___WORKSPACE_PATH___/$VFLOPPY_FILENAME
VFLOPPY_MOUNT_PATH=$___WORKSPACE_PATH___/mnt

mkdir -p $VFLOPPY_MOUNT_PATH
mkdir -p $OUTPUT_PATH

################################################################################
#
# MAIN() - VIRTUAL FLOPPY DISK CREATION
#
################################################################################

echo "################################################################################"
echo "#"
echo "# create-virtual-floppy.sh"
echo "#"
echo "################################################################################"
echo "With data:"
tree $INPUT_PATH
echo "################################################################################"

# Create file
fallocate -l 1474560 $VFLOPPY_FILE_PATH
# Format file
mkfs.vfat $VFLOPPY_FILE_PATH
# Mount virtual floppy
sudo mount -o loop $VFLOPPY_FILE_PATH $VFLOPPY_MOUNT_PATH
# Copy desired data
sudo cp $INPUT_PATH/* $VFLOPPY_MOUNT_PATH
# Unmount virtual floppy
sudo umount $VFLOPPY_MOUNT_PATH

# Enjoy !

# Move result virtual floppy from workspace to output directory
OUTPUT_FILE_PATH=$OUTPUT_PATH/$VFLOPPY_NAME-$(date '+%Y-%m-%dT%H-%M-%S').$VFLOPPY_EXTENSION
mv $VFLOPPY_FILE_PATH $OUTPUT_FILE_PATH

echo "DONE: create-virtual-floppy.sh"
echo "    * Created: $(du -h $OUTPUT_FILE_PATH)"

################################################################################
#
# CLEANUP
#
################################################################################

rm -rf $___WORKSPACE_PATH___

echo "################################################################################"
echo "#"
echo "# DONE create-virtual-floppy.sh"
echo "#"
echo "################################################################################"
