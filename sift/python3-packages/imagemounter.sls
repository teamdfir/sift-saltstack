# Name: imagemounter
# Website: https://github.com/ralphje/imagemounter
# Description: Command line utility and Python package to mount/unmount forensic disk images
# Category:
# Author: Ralph Broenink
# License: MIT License (https://github.com/ralphje/imagemounter/blob/master/LICENSE)
# Notes: imount

include:
  - sift.packages.python3-virtualenv
  - sift.packages.afflib-tools
  - sift.packages.avfs
  - sift.packages.disktype
  - sift.packages.file
  - sift.packages.libbde
  - sift.packages.libbde-tools
  - sift.packages.libewf-tools
  - sift.packages.libvshadow-tools
  - sift.packages.lvm2
  - sift.packages.mdadm
  - sift.packages.ntfs-3g
  - sift.packages.qemu-utils
  - sift.packages.sleuthkit
  - sift.packages.testdisk
  - sift.packages.vmfs-tools
  - sift.packages.xfsprogs
  - sift.packages.mtd-utils
  - sift.packages.squashfs-tools
  - sift.packages.git
  - sift.packages.build-essential
  - sift.packages.python3-dev
  - sift.packages.python3-pytsk3

sift-python3-package-imagemounter-venv:
  virtualenv.managed:
    - name: /opt/imagemounter
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - python-magic>=0.4.27
      - pytsk3>=20231007
    - require:
      - sls: sift.packages.python3-virtualenv
      - sls: sift.packages.build-essential
      - sls: sift.packages.afflib-tools
      - sls: sift.packages.avfs
      - sls: sift.packages.disktype
      - sls: sift.packages.file
      - sls: sift.packages.libbde
      - sls: sift.packages.libbde-tools
      - sls: sift.packages.libewf-tools
      - sls: sift.packages.libvshadow-tools
      - sls: sift.packages.lvm2
      - sls: sift.packages.mdadm
      - sls: sift.packages.ntfs-3g
      - sls: sift.packages.qemu-utils
      - sls: sift.packages.sleuthkit
      - sls: sift.packages.testdisk
      - sls: sift.packages.vmfs-tools
      - sls: sift.packages.xfsprogs
      - sls: sift.packages.mtd-utils
      - sls: sift.packages.squashfs-tools
      - sls: sift.packages.git
      - sls: sift.packages.python3-dev
      - sls: sift.packages.python3-pytsk3

sift-python3-package-imagemounter:
  pip.installed:
    - name: imagemounter
    - bin_env: /opt/imagemounter/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-imagemounter-venv

sift-python3-package-imagemounter-symlink:
  file.symlink:
    - name: /usr/local/bin/imount
    - target: /opt/imagemounter/bin/imount
    - makedirs: False
    - require:
      - pip: sift-python3-package-imagemounter
