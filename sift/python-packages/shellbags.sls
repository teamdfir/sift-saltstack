{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - sift.packages.git
  - sift.packages.python-pip

shellbags:
  pip.installed:
    - name: git+https://github.com/williballenthin/shellbags.git@fee76eb
    - require:
      - pkg: git
      - pkg: python-pip
