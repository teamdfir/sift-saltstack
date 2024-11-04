include:
  - sift.packages.python2-pip
  - sift.packages.swig
  - sift.packages.python2-dev
  - sift.packages.libssl-dev
  - sift.packages.build-essential

sift-python-packages-m2crypto:
  pip.installed:
    - name: m2crypto==0.40.1
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.packages.swig
      - sls: sift.packages.python2-dev
      - sls: sift.packages.libssl-dev
      - sls: sift.packages.build-essential
