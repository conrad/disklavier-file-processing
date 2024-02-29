## From Brian:

- Goal: To organize a number of files into virtual floppy disks that can be read bya Disklavier player.
- Resource: This website has videos and all resources needed: https://floppyusbemulator.com/no-midi-support

- Details:
  - There is a folder (DiskLavier Files) with several zip files labeled as “Albums” filled with tracks which are .FIL

  - In order for these to be readable, they need to be converted to individual virtual 3.5” floppies which include the .FIL files as well as an index file (always called PIANODIR.FIL)

- Current Process:
  1. Convert downloads from ZIP to folders - DONE
  2. Organize folders into folders of size 713 KB or less (if original folder was much larger, name the folders appropriately, ie Jazz 1, Jazz 2, Jazz 3)
  3. Drag folder into DOS Floppy Disk File Browser (this is the software: Direct download link) and convert to virtual floppy disk

## Script Specs
1. Check memory size of directory
  1. If smaller than 713KB, copy all of directory to output directory
  2. If larger than 713KB:
    1. divide by 713KB and create that many directories of the same name but numbered
    2. divide the number of files by the number of directories
    3. copy that number of files to each directory
2. Check that all output directories are less than 713KB
3. Convert each directory to a virtual floppy disk


1344

## Notes

- Virtual Floppy Drive is a simple application whose goal is to give you the possibility to create virtual drives and use them as if they were real ones.
- A virtual hard drive file is a container file that acts similar to a physical hard drive. Like a physical hard drive, a virtual hard drive file contains a file system, and it can contain an operating system, applications and data.
- wiki on virtual drive: https://en.wikipedia.org/wiki/Virtual_disk_and_virtual_drive

### Tools / conversion options
1. conversion util repo: https://github.com/wbwiltshire/VFDTool
2. gist script: https://gist.github.com/iamsortiz/1bdb9774832ea65855b2dc1b9b4ee8dc
3. wordpress post: https://madlabber.wordpress.com/2019/06/13/how-to-create-floppy-disk-images-on-macos/
4. techplay post (0lder): https://techatplay.wordpress.com/2011/08/07/how-to-create-floppy-disk-image-in-os-x/


## Questions for Brian
