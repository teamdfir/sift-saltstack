include:
  - sift.packages.python2-pip

sift-python-packages-windowsprefetch:
  pip.installed:
    - name: windowsprefetch
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
