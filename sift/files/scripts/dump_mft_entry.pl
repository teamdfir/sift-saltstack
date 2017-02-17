#!/usr/bin/perl

#------------------------------
#dump_mft_entry.pl
#
#Dave Lassalle, @superponible
#email: dave@superponible.com
#------------------------------
#
#This will dump the contents of the MFT entry number in the provided file using hexdump
#

if (@ARGV != 2) {
    print "Usage: dump_mft_entry.pl MFT_Entry_Number MFT_File\n";
    exit 1;
}

($inode,$mft) = @ARGV;

$hex_offset = sprintf("%x", $inode * 1024);

system("hexdump -s 0x$hex_offset -v -n 1024 -e '/1024 \"%010_ax\"\"\n\"\"\"' -e '512/1 \"%02X \"\"\n\"\"\"' -e '1024/1 \"%_p\"\"\n\"' $mft");
exit 0;


