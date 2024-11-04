include:
  - sift.packages.git
  - sift.packages.python2-pip
  - sift.packages.python2-dev
  - sift.packages.build-essential

pydasm:
  pip.installed:
    - name: git+https://github.com/jtpereyda/libdasm.git@68d61b1#egg=version_subpkg&subdirectory=pydasm
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
      - sls: sift.packages.python2-dev
      - sls: sift.packages.build-essential
