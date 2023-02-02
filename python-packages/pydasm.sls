include:
  - sift.packages.git
  - sift.packages.python3-pip
  - sift.packages.python2-pip

pydasm:
  pip.installed:
    - name: git+https://github.com/jtpereyda/libdasm.git@68d61b1#egg=version_subpkg&subdirectory=pydasm
    - bin_env: /usr/bin/python2
#    - editable: git+https://github.com/jtpereyda/libdasm.git@68d61b1#egg=version_subpkg&subdirectory=pydasm
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
