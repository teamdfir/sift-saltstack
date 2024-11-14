{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}
{%- set commit = "038e8ec836cf23600124db74b40757b7184c08c5" -%}

include:
  - sift.packages.git
  - sift.packages.python3-pip
  - sift.packages.python3-dev

sift-python-packages-indxparse:
  pip.installed:
    - name: git+https://github.com/williballenthin/INDXParse.git@{{ commit }}
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python3-pip
      - sls: sift.packages.python3-dev
