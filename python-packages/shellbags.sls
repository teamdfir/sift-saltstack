{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - sift.packages.git
  - sift.packages.python3-pip
  - sift.packages.python2-pip

shellbags:
  pip.installed:
    - name: git+https://github.com/williballenthin/shellbags.git@fee76eb
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip
