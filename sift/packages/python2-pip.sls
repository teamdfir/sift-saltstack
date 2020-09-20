include:
  - sift.packages.python2
  - sift.packages.curl

{%- if grains['oscodename'] == "bionic" %}
sift-package-python2-pip:
  pkg.installed:
    - name: python-pip
    - require:
      - sls: sift.packages.python2

{%- elif grains['oscodename'] == "focal" %}
sift-package-python2-pip-install-script:
  cmd.run:
    - name: curl -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py 
    - require:
      - sls: sift.packages.python2
      - sls: sift.packages.curl

sift-package-python2-pip-install:
  cmd.run:
    - name: python2 /tmp/get-pip.py
    - require:
      - cmd: sift-package-python2-pip-install-script
{%- endif %}