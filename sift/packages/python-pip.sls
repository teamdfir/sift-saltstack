include:
  - sift.packages.python

python-pip:
  pkg.installed:
    - name: python-pip
    - require:
      - sls: sift.packages.python
