{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - sift.packages.git
  - sift.packages.python3-pip

shellbags:
  pip.installed:
    - name: git+https://github.com/williballenthin/shellbags.git@fee76eb
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python3-pip
