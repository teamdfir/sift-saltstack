/etc/rc.local:
  file.append:
    - text: 'for i in `seq 8 100`; do mknod /dev/loop$i b 7 $i; done'
