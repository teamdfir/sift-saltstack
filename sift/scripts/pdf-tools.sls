# Name: pdf-tools
# Website: https://blog.didierstevens.com/programs/pdf-tools/
# Description: A collection of python scripts used for parsing PDF's
# Category: 
# Author: Didier Stevens
# License: Free, Public Domain
# Notes: make-pdf-embedded.py, make-pdf-helloworld.py, make-pdf-javascript.py, pdfid.py, pdf-parser.py, pdftool.py

{% set files = ['make-pdf-embedded.py','make-pdf-helloworld.py','make-pdf-javascript.py','mPDF.py','pdfid.py','pdf-parser.py','pdftool.py','plugin_embeddedfile.py','plugin_nameobfuscation.py','plugin_triage.py'] %}

include:
  - sift.packages.python3-virtualenv

sift-python3-package-pdf-tools-venv:
  virtualenv.managed:
    - name: /opt/pdf-tools
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-pdf-tools:
  file.recurse:
    - name: /opt/pdf-tools/bin/
    - source: salt://sift/files/pdf-tools
    - file_mode: 755

{% for file in files %}
sift-python3-package-pdf-tools-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/pdf-tools/bin/{{ file }}
    - makedirs: False
    - require:
      - file: sift-python3-package-pdf-tools
{% endfor %}
