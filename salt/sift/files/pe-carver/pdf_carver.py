## Stupid, simple, PDF carver - by @bbaskin

import sys

try:
  fname = sys.argv[1]
except IndexError:
	print "Please specify file to carve PDFs from."
	quit()
	
	
f = open(fname, 'rb')
inPDF = False
count = 0
while f:
    byte = f.read(1)
    if byte == b"":
        break
    if byte == "%":
        if inPDF:
            byte2 = f.read(4)
            if byte2 == "%EOF":
                PDF_end =  f.tell()
                
                PDF_size = PDF_end - PDF_begin 
                f.seek(PDF_begin)
                pdf = f.read(PDF_size)
                outfname = fname + "_%s.pdf" % count
                print "Out: %s\t Offset: 0x%x\t Size: %d\t End Offset: 0x%x" % (outfname, PDF_begin, PDF_size, PDF_end)
                open(outfname, 'wb').write(pdf)
                count += 1
                inPDF = False
        else:
            byte2 = f.read(3)
            if byte2 == "PDF":
                PDF_begin =  f.tell() - 4
                inPDF = True
f.close()
