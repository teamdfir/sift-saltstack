{%- set user = salt['pillar.get']('sift_user', 'sansforensics') -%}

include:
  - ..packages.git
  - ..packages.pkg-config
  - ..packages.python-pip

indxparse:
  pip.installed:
    - name: git+https://github.com/williballenthin/INDXParse.git@14839a6
    - user: sift-user-{{ user }}
    - require:
      - pkg: git
      - pkg: pkg-config
      - pkg: python-pip
