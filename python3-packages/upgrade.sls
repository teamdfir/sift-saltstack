argparse.sls:    - upgrade: True
bitstring.sls:    - upgrade: True
colorama.sls:    - upgrade: True
geoip2.sls:    - upgrade: True
ioc_writer.sls:    - upgrade: True
lxml.sls:    - upgrade: True
pefile.sls:    - upgrade: True
pillow.sls:    - upgrade: True
pyhindsight.sls:    - upgrade: True
python-dateutil.sls:    - upgrade: True
python-evtx.sls:    - upgrade: True
python-magic.sls:    - upgrade: True
python-registry.sls:    - upgrade: True
setuptools.sls:    - upgrade: True
six.sls:    - upgrade: True
stix-validator.sls:    - upgrade: True
stix.sls:    - upgrade: True
virustotal-api.sls:    - upgrade: True
wheel.sls:    - upgrade: True
yara-python.sls:    - upgrade: True

include:
  - sift.python3-packages.pip
  - sift.python3-packages.argparse
  - sift.python3-packages.bitstring
  - sift.python3-packages.colorama
  - sift.python3-packages.geoip2
  - sift.python3-packages.ioc_writer
  - sift.python3-packages.lxml
  - sift.python3-packages.pefile
  - sift.python3-packages.pillow
  - sift.python3-packages.pyhindsight
  - sift.python3-packages.python-dateutil
  - sift.python3-packages.python-evtx
  - sift.python3-packages.python-magic
  - sift.python3-packages.python-registry
  - sift.python3-packages.setuptools
  - sift.python3-packages.setuptools-rust
  - sift.python3-packages.six
  - sift.python3-packages.stix-validator
  - sift.python3-packages.stix
  - sift.python3-packages.virustotal-api
  - sift.python3-packages.wheel
  - sift.python3-packages.yara-python

sift-python3-packages-upgrade:
  cmd.run:
    - name: /usr/bin/python3 -m pip install --upgrade argparse bitstring colorama geoip2 ioc_writer lxml pefile pillow pyhindsight python-dateutil python-evtx python-magic python-registry setuptools setuptools_rust six stix-validator stix virustotal-api wheel yara-python pip
    - require:
      - sls: sift.python3-packages.pip
      - sls: sift.python3-packages.argparse
      - sls: sift.python3-packages.bitstring
      - sls: sift.python3-packages.colorama
      - sls: sift.python3-packages.geoip2
      - sls: sift.python3-packages.ioc_writer
      - sls: sift.python3-packages.lxml
      - sls: sift.python3-packages.pefile
      - sls: sift.python3-packages.pillow
      - sls: sift.python3-packages.pyhindsight
      - sls: sift.python3-packages.python-dateutil
      - sls: sift.python3-packages.python-evtx
      - sls: sift.python3-packages.python-magic
      - sls: sift.python3-packages.python-registry
      - sls: sift.python3-packages.setuptools
      - sls: sift.python3-packages.setuptools-rust
      - sls: sift.python3-packages.six
      - sls: sift.python3-packages.stix-validator
      - sls: sift.python3-packages.stix
      - sls: sift.python3-packages.virustotal-api
      - sls: sift.python3-packages.wheel
      - sls: sift.python3-packages.yara-python

