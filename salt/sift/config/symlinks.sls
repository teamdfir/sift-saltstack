# TODO: needed in trusty maybe?? not needed in xenial, might be new build of libyal stuff
#/usr/bin/vol.py:
#  file.symlink:
#    - target: /usr/bin/vol

#/usr/bin/gedit:
#  file.symlink:
#    - target: /usr/bin/kedit

#/usr/bin/ewfmount:
#  file.symlink:
#    - target: /usr/bin/mount_ewf.py

#/usr/bin/mactime:
#  file.symlink:
#    - target: /usr/local/bin/mactime-sleuthkit

{%- if grains['oscodename'] == "trusty" %}
# Fix for https://github.com/sans-dfir/sift/issues/10
/usr/bin/icat:
  file.symlink:
    - target: /usr/bin/icat-sleuthkit 
{%- endif %}

/usr/bin/log2timeline_legacy:
  file.symlink:
    - target: /usr/bin/log2timeline

# Fix for https://github.com/sans-dfir/sift/issues/23
/usr/bin/l2t_process_old.pl:
  file.symlink:
    - target: /usr/local/bin/l2t_process

{% if grains['oscodename'] == "xenial" -%}
/usr/lib/libewf.so.2:
  file.symlink:
    - target: /usr/lib/libewf.so.3
{%- endif %}

/usr/bin/iscsiadm:
  file.symlink:
    - target: /sbin/iscsiadm

/usr/local/bin/rip.pl:
  file.symlink:
    - target: /usr/share/regripper/rip.pl
