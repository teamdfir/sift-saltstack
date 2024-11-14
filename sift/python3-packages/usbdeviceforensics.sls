# source=https://github.com/digitalsleuth/usbdeviceforensics
# license=unknown

include:
  - sift.python3-packages.core
  - sift.packages.git

sift-python3-package-usbdeviceforensics:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/usbdeviceforensics.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.packages.git

