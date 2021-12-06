include:
  - sift.python-packages.volatility
  - sift.scripts.regripper

/usr/bin/vol.py:
  file.symlink:
    - target: /usr/bin/vol
    - require:
      - sls: sift.python-packages.volatility

#/usr/bin/gedit:
#  file.symlink:
#    - target: /usr/bin/kedit

#/usr/bin/ewfmount:
#  file.symlink:
#    - target: /usr/bin/mount_ewf.py

# Just in case it is needed 4/18
/usr/bin/mactime:
  file.symlink:
    - target: /usr/local/bin/mactime-sleuthkit

# Fix for https://github.com/sans-dfir/sift/issues/10
/usr/bin/icat:
  file.symlink:
    - target: /usr/bin/icat-sleuthkit 

/usr/bin/log2timeline_legacy:
  file.symlink:
    - target: /usr/bin/log2timeline
    - require:
      - pkg: python-plaso

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
    - require:
      - file: regripper-files
