include:
  - sift.packages.git
  - sift.packages.python3-pip

pydasm:
  pip.installed:
    - name: git+https://github.com/jtpereyda/libdasm.git@68d61b1#egg=version_subpkg&subdirectory=pydasm
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python3-pip
