#!/usr/bin/env python
'''
Copyright (C) 2013 Kevin Breen.
Python script to MNT Partitions on a Disk Image
http://techanarchy.net
'''
__description__ = 'Python script to MNT Partitions on a Disk Image'
__author__ = 'Kevin Breen @KevTheHermit'
__version__ = '0.5'
__date__ = '2014/09/13'
 
 
import os
import sys
import hashlib
import commands
import subprocess
from datetime import datetime
from optparse import OptionParser, OptionGroup
 
supported_types = ['0x83', '0x07', '0x0b', '0x06', '0x17', '0x16', '0x1b', 'Basic data partition']
vfat = ['0x0b', '0x06', '0x1b', '0x16']
ntfs = ['0x07', '0x17', 'Basic data partition']
 
 
def parse_mmls(img_path):
    # use mmls to get a list of partitions.
    try:
        mmls_output = commands.getoutput("mmls {0}".format(img_path))
    except Exception as e:
        print "[+] MMLS Failed with Exception {0}".format(e)
        return False, False
    #Build a Dictionary containing all the Partition Information
    partition_info = {}
    part_count = 0
    for line in mmls_output.split('\n'):
        if line == 'Cannot determine partition type':
            print "[+] Image file doesnt Contain a Partition Table"
            print "[+] If this is a single partition try the '-s' option"
            sys.exit()
        # We need sector size.
        if line.startswith('Units'):
            sector_size = int(line.split()[3].split('-')[0])
        # we need to get all the partitions. But only supported ones
        if any(fs_type in line for fs_type in supported_types):
            # Dict for single part
            inf = {}
            line_info = line.split('   ')
            if len(line_info) == 5:
                inf['Start'] = int(line_info[1])
                inf['End'] = int(line_info[2])
                inf['Length'] = int(line_info[3])
                inf['Type'] = line_info[4].split('(')[1][:-1]
            elif len(line_info) == 6:
                inf['Start'] = int(line_info[2])
                inf['End'] = int(line_info[3])
                inf['Length'] = int(line_info[4])
                inf['Type'] = line_info[5]
            # Calculated offset
            inf['Offset'] = inf['Start'] * sector_size
            # add partition to list of all parts
            partition_info[part_count] = inf
            part_count += 1
    return partition_info, part_count
             
def mount_single(img_file, mnt_path):
    if not os.path.exists(mnt_path):
        os.makedirs(mnt_path)
    print "[+] Attempting to Mount {0} at {1}".format(img_file, mnt_path)
    try:
        retcode = subprocess.call("mount -o ro,loop,show_sys_files,streams_interface=windows {0} {1}" .format(img_file, mnt_path), shell=True)
        #Crappy error Handling here
        if retcode != 0:
            sys.exit()
        print "   [-] Mounted {0} at {1}".format(img_file, mnt_path)
        print "   [-] To unmount run 'sudo umount %s'" % mnt_path
    except:
        print "[+] Failed to Mount %s" % mnt_path
 
def mount_multi(img_file, mnt_path, part_count, part_data):
    for i in range(part_count):
        new_path = os.path.join(mnt_path, str(i))
        print "[+] Creating Temp Mount Point at {0}".format(new_path)
        if not os.path.exists(new_path):
            os.makedirs(new_path)
        print "[+] Attempting to Mount Partition {0} at {1}".format(i, new_path)
        try:
            offset = part_data[i]["Offset"]
            fs_type = part_data[i]["Type"]
            if fs_type in vfat:
                fs_type = 'vfat'
            if fs_type in ntfs:
                fs_type = 'ntfs'
            retcode = subprocess.call('mount -t {0} -o ro,loop,show_sys_files,streams_interface=windows,offset={1} {2} {3}' .format(fs_type, offset, img_file, new_path), shell=True)
            #Crappy error Handling here
            if retcode != 0:
                sys.exit()
            print "   [-] Mounted {0} at {1}".format(img_file, new_path)
            print "   [-] To unmount run 'sudo umount {0}'".format(new_path)
        except:
            print "[+] Failed to Mount {0}".format(new_path)
 
def ewf_mount(img_file):
    print "[+] Processing E01 File"
    #check we have an EO file
    if img_file.endswith('.E01'):
        # create a tmp mnt point
        ts = datetime.now().strftime('%Y_%m_%d-%H_%S')
        ewf_path = '/mnt/ewf_{0}'.format(ts)
        if not os.path.exists(ewf_path):
            try:
                os.makedirs(ewf_path)
            except Exception as e:
                print "Unable to create Temp Dir: {0}".format(e)
                sys.exit()
        # Run ewfmount
        try:
            retcode = subprocess.call('ewfmount {0} {1}'.format(img_file, ewf_path), shell=True)
            if retcode != 0:
                sys.exit()
            print "[+] Mounted E0 File at {0}".format(ewf_path+'/ewf1')
            print "   [-] to unmount run 'sudo umount {0}'".format(ewf_path)
            return ewf_path+'/ewf1'
        except Exception as e:
            print "Failed to mount E0 File: {0}".format(e)
            sys.exit()
 
def bitlock_mount(img_file, mnt_path, recover_key, part_data):
    # for now we only support recovery key
    offset = part_data[0]['Offset']
    print "[+] Processing Bitlocked Drive"
    #check we have an EO file
    ts = datetime.now().strftime('%Y_%m_%d-%H_%S')
    bitlock_path = '/mnt/bde_{0}'.format(ts)
    if not os.path.exists(bitlock_path):
        try:
            os.makedirs(bitlock_path)
        except Exception as e:
            print "Unable to create Temp Dir: {0}".format(e)
            sys.exit()
    # Run bdemount
    try:
        retcode = subprocess.call('bdemount -r {0} -o {1} {2} {3}'.format(recover_key, offset, img_file, bitlock_path), shell=True)
        if retcode != 0:
            sys.exit()
        print "[+] Mounted Bitlocker File at {0}".format(bitlock_path+'/bde1')
        print "   [-] to unmount run 'sudo umount {0}'".format(bitlock_path)
        img_path = bitlock_path+'/bde1'
    except Exception as e:
        print "Failed to mount File: {0}".format(e)
        sys.exit()
    mount_single(img_path, mnt_path)
 
 
def main():
    parser = OptionParser(usage='usage: %prog [options] image_name mnt_point\n' + __description__, version='%prog ' + __version__)
    parser.add_option("-s", "--single", action='store_true', default=False, help="Single partition in image")
    parser.add_option("-i", "--info", action='store_true', default=False, help="Just Display the information")
    parser.add_option("-e", "--e01", action='store_true', default=False, help="Use ewfmount to mount E0 Evidence Files")
    parser.add_option("-b", "--bitlocker", action='store_true', default=False, help="Mount Bitlocker Drive with Recovery Key")
    parser.add_option("-k", "--key", dest='recover_key', default=False, help="Bitlocker Recovery Key")
    (options, args) = parser.parse_args()
 
    if len(args) == 0:
        print "[+] You need to give me some Paths"
        parser.print_help()
        sys.exit()
 
    # Sort args
    img_file = args[0]
    mnt_path = args[1]
     
    # Dont trust the user force E01 Check
    if img_file.endswith('.E01'):
        options.e01 = True
     
    # We need to proces E0 Files before anythign else
    if options.e01:
        # mount the ewf and use this as our new img_file
        img_file = ewf_mount(img_file)
 
    # Single partition. We have no mmls data so jsut try mounting
    if options.single:
        mount_single(img_file, mnt_path)
     
    # Mount a Disk with multi parts
    if not options.single and not options.bitlocker:
        # Get partition Information
        part_data, part_count = parse_mmls(img_file)
        if part_data:
            mount_multi(img_file, mnt_path, part_count, part_data)
 
    # Mount a BitLocked Drive
    if options.bitlocker and options.recover_key:
        part_data, part_count = parse_mmls(img_file)
        bitlock_mount(img_file, mnt_path, options.recover_key, part_data)
 
 
if __name__ == "__main__":
    if os.getuid() == 0:
        main()
    else:
        print "[+] You must be Root or Sudo to run this Script"
        sys.exit()
             
            
